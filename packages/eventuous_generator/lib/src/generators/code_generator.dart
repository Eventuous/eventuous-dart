import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';

abstract class CodeGenerator<T> extends GeneratorForAnnotation<T> {
  CodeGenerator(this.config);

  final Map<String, Object?> config;

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final inference = await _read(element, buildStep);
    return generateForType(inference, element, annotation).toString();
  }

  String generateForType(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  );

  Future<InferenceModel> _read(Element element, BuildStep buildStep) async {
    final json = await buildStep.readAsString(_toInferenceAssetId(buildStep));
    return InferenceModel.fromJson(jsonDecode(json));
  }

  AssetId _toInferenceAssetId(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', 'inference.json'),
    );
  }
}
