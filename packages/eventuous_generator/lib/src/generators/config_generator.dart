import 'dart:async';
import 'dart:convert';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:eventuous_generator/src/templates/eventuous_config_template.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

import '../helpers.dart';

class ConfigGenerator extends GeneratorForAnnotation<Eventuous> {
  ConfigGenerator(this.config);

  final Map<String, Object?> config;

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final root = const TypeChecker.fromRuntime(Eventuous)
        .firstAnnotationOf(element, throwOnUnresolved: false);
    final eventuous = parseConfig(config, root);
    final inference = await _read(element, buildStep);
    return EventuousConfigTemplate.from(eventuous, inference).toString();
  }

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
