import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eventuous_generator/src/extensions.dart';
import 'package:eventuous_generator/src/generators/api_spec_generator.dart';
import 'package:eventuous_generator/src/helpers.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import 'models/inference_model.dart';

const Map<Type, TypeChecker> checkers = {
  GrpcServiceType: TypeChecker.fromRuntime(GrpcServiceType),
};

/// Generate API specifications from annotations.
abstract class ApiSpecBuilder implements Builder {
  ApiSpecBuilder(
    Map<String, Object?> config,
    ApiSpecGenerator generator,
  )   : _config = config,
        _generator = generator;

  Map<String, Object?> get config => Map.from(_config);
  final Map<String, Object?> _config;

  /// The generator for given api.
  final ApiSpecGenerator _generator;

  @override
  Map<String, List<String>> get buildExtensions {
    final allowedOutputs = <String, List<String>>{};
    // Based on inspiration from
    // https://simonbinder.eu/posts/build_directory_moves
    final extensions = config.remove('build_extensions');
    if (extensions is Map) {
      for (var entry in extensions.entries) {
        allowedOutputs[entry.key as String] =
            // Map entry to generator-specific output pattern
            _generator.toAllowedOutput(entry.value is List
                ? (entry.value as List).cast<String>()
                : [entry.value.toString()]);
      }
    } else {
      allowedOutputs['^lib/{{}}.dart'] =
          // Default to parsing all dart files
          _generator.toAllowedOutput();
    }
    return allowedOutputs;
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inference = await readInference(config, buildStep);

    final library = await buildStep.resolver.libraryFor(buildStep.inputId);
    final buffers = <String, StringBuffer>{};
    for (var clz in LibraryReader(library).classes) {
      for (var check in checkers.entries) {
        if (check.value.hasAnnotationOfExact(clz)) {
          final annotation = _firstAnnotationOf(check, clz);
          await _build(inference, clz, ConstantReader(annotation), buffers);
        }
      }
    }
    final content = StringBuffer();
    for (var buffer in buffers.values) {
      content.write(buffer);
    }
    if (content.isNotEmpty) {
      final spec = StringBuffer();
      spec.writeln(r'syntax = "proto3";');
      spec.writeln();
      spec.writeln(r'import "google/protobuf/empty.proto";');
      spec.writeln();
      spec.write(content);
      final outputId = _generator.toAssetId(buildStep);
      await buildStep.writeAsString(outputId, spec.toString());
    }
  }

  Future<void> _build(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
    Map<String, StringBuffer> buffers,
  ) async {
    final aggregate = annotation.toFieldTypeName('aggregate');
    if (!buffers.containsKey(aggregate)) {
      final content = await _generator.generateApi(
        inference,
        element,
        annotation,
      );
      if (content.isNotEmpty) {
        buffers[aggregate] = StringBuffer(content);
      }
    }
  }

  DartObject? _firstAnnotationOf(
      MapEntry<Type, TypeChecker> check, ClassElement clz) {
    return check.value.firstAnnotationOf(clz, throwOnUnresolved: false);
  }
}
