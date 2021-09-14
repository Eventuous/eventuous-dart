import 'dart:async';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/templates/aggregate_template.dart';
import 'package:source_gen/source_gen.dart';

class EventuousGenerator extends GeneratorForAnnotation<AggregateType> {
  EventuousGenerator(this.config);

  final Map<String, Object?> config;

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final root = const TypeChecker.fromRuntime(Eventuous)
        .firstAnnotationOf(element.library!, throwOnUnresolved: false);
    final eventuous = _parseConfig(root);
    final aggregate = AggregateTemplate.from(eventuous, element, annotation);
    if (root == null) {
      log.warning(
        '''
Annotation @Eventuous not found. You need to call define${aggregate.name}Types() before using ${aggregate.name}.
''',
      );
    }
    return aggregate.toString();
  }

  Eventuous _parseConfig(DartObject? annotation) {
    final inferTypes = annotation?.getField('inferTypes')?.toBoolValue() ??
        config['infer_types'] as bool? ??
        true;

    return Eventuous(
      inferTypes: inferTypes,
    );
  }
}
