import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/templates/eventuous_config_template.dart';
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
  ) {
    final root = const TypeChecker.fromRuntime(Eventuous)
        .firstAnnotationOf(element, throwOnUnresolved: false);
    final eventuous = parseConfig(config, root);
    return EventuousConfigTemplate.from(eventuous).toString();
  }
}
