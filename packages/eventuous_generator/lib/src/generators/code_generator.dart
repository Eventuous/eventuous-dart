import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eventuous/eventuous.dart';
import 'package:path/path.dart' as p;
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
    final inference = await _read(element, buildStep);
    return generateForClass(inference, element, annotation).toString();
  }

  String generateForClass(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
  );

  Future<InferenceModel> _read(Element element, BuildStep buildStep) async {
    final json = await buildStep.readAsString(_toInferenceAssetId(buildStep));
    return InferenceModel.fromJson(JsonMap.from(jsonDecode(json) as Map));
  }

  AssetId _toInferenceAssetId(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', 'inference.json'),
    );
  }
}
