import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/templates/aggregate_state_template.dart';
import 'package:eventuous_generator/src/templates/aggregate_value_template.dart';
import 'package:source_gen/source_gen.dart';

import 'extensions.dart';

String inferTData(
  Eventuous eventuous,
  Element element,
  ElementAnnotation annotation,
) {
  final data = annotation.computeConstantValue()!.getField('data');
  log.warning('$data');
  log.warning(
      'null: ${data == null || data.isNull || data.toTypeValue() == null}');
  log.warning('inferTypes: ${eventuous.inferTypes}');
  log.warning(
      'usesJsonSerializable: ${element.metadata.usesJsonSerializable()}');
  return data == null || data.isNull || data.toTypeValue() == null
      ? (eventuous.inferTypes || element.metadata.usesJsonSerializable()
          ? 'JsonMap'
          : 'Object')
      : data.toTypeValue()!.toTypeName();
}

String inferTValue(
  Eventuous eventuous,
  DartType? annotation,
  String aggregate, [
  List<AggregateValueTemplate> values = const [],
]) {
  return annotation == null || annotation.isDartCoreNull
      ? eventuous.inferTypes
          ? values.isNotEmpty
              ? values.first.name
              : '${aggregate}Value'
          : 'Object'
      : annotation.toTypeName();
}

String inferTState(
  Eventuous eventuous,
  ConstantReader annotation,
  String aggregate,
  List<AggregateStateTemplate> states,
) {
  if (states.isEmpty) {
    throw InvalidGenerationSourceError(
      'No @AggregateState annotation found for $aggregate',
    );
  }
  final state = annotation.read('state');
  var type = state.isNull
      ? eventuous.inferTypes
          ? states.first.name
          : '${aggregate}State'
      : state.typeValue.toTypeName();
  if (states.isNotEmpty) {
    if (!states.any((t) => t.name == type)) {
      throw InvalidGenerationSourceError(
        '$type not annotated with @AggregateState for $aggregate',
      );
    }
  }
  return type;
}
