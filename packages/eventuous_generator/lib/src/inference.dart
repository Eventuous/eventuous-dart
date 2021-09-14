import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/templates/aggregate_event_template.dart';
import 'package:eventuous_generator/src/templates/aggregate_state_template.dart';
import 'package:eventuous_generator/src/templates/aggregate_value_template.dart';
import 'package:source_gen/source_gen.dart';

import 'extensions.dart';

String inferTData(
  Eventuous eventuous,
  Element element,
  ElementAnnotation annotation, [
  List<AggregateEventTemplate> events = const [],
]) {
  final data = annotation.computeConstantValue()?.getField('data');
  final dataTypes = events.map((t) => t.data).toSet();
  if (dataTypes.length > 1) {
    log.warning(
      'Found multiple TData types in events: [${dataTypes.join(',')}], '
      'using the first: ${dataTypes.first}',
    );
  }
  final usesJsonSerializable = element.metadata.usesJsonSerializable() ||
      events.any((e) => e.usesJsonSerializable);
  return data == null || data.isNull || data.toTypeValue() == null
      ? (eventuous.inferTypes || usesJsonSerializable
          ? (events.isNotEmpty
              ? events.first.data
              : usesJsonSerializable
                  ? 'JsonMap'
                  : 'Object')
          : 'Object')
      : data.toTypeValue()!.toTypeName();
}

String inferTEvent(
  Eventuous eventuous,
  Element element,
  ElementAnnotation annotation, [
  List<AggregateEventTemplate> events = const [],
]) {
  final event = annotation.computeConstantValue()?.getField('event');
  final usesJsonSerializable = element.metadata.usesJsonSerializable() ||
      events.any((e) => e.usesJsonSerializable);
  return event == null || event.isNull || event.toTypeValue() == null
      ? (eventuous.inferTypes || usesJsonSerializable ? 'JsonObject' : 'Object')
      : event.toTypeValue()!.toTypeName();
}

String inferTValue(
  Eventuous eventuous,
  Element element,
  DartType? annotation,
  String aggregate, [
  List<AggregateValueTemplate> values = const [],
]) {
  final usesJsonSerializable = element.metadata.usesJsonSerializable();
  final type =
      usesJsonSerializable || annotation == null || annotation.isDartCoreNull
          ? eventuous.inferTypes || values.isNotEmpty
              ? values.first.name
              : '${aggregate}Value'
          : annotation.toTypeName();

  if (usesJsonSerializable && type == 'Object') {
    throw InvalidGenerationSourceError(
      "TValue of type '$type' does not implement "
      "static method 'fromJson'. Please specify value with "
      "the annotation for '${element.displayName}.'",
    );
  }
  return type;
}

String inferTState(
  Eventuous eventuous,
  ConstantReader annotation,
  String aggregate,
  List<AggregateStateTemplate> states,
) {
  if (states.isEmpty) {
    throw InvalidGenerationSourceError(
      'No @AggregateStateType annotation found for $aggregate',
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
        '$type not annotated with @AggregateStateType for $aggregate',
      );
    }
  }
  return type;
}
