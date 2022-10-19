import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eventuous_generator/src/helpers.dart';
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';
import '../extensions.dart';

abstract class CodeGenerator<T> extends GeneratorForAnnotation<T> {
  CodeGenerator(this.config);

  final Map<String, Object?> config;

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '${annotation.typeValue.toTypeName()} is only allowed on classes',
      );
    }
    final inference = await readInference(config, buildStep);
    return generateForClass(inference, element, annotation).toString();
  }

  String generateForClass(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
  );
}
