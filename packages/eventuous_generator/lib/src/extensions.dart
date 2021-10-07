import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:source_gen/source_gen.dart';

import 'builders/models/annotation_model.dart';
import 'builders/models/parameterized_type_model.dart';
import 'templates/aggregate_event_template.dart';
import 'templates/aggregate_state_template.dart';
import 'templates/aggregate_template.dart';
import 'templates/aggregate_value_template.dart';

extension StringX on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

extension AnnotationModelX on AnnotationModel {
  AggregateTemplate toAggregateTemplate(
    String name,
    InferenceModel inference,
  ) {
    return AggregateTemplate(
      name: name,
      id: (this['id'] as ParameterizedTypeModel).value,
      event: (this['event'] as ParameterizedTypeModel).value,
      value: (this['value'] as ParameterizedTypeModel).value,
      state: (this['state'] as ParameterizedTypeModel).value,
      events: inference
          .annotationsOf<AggregateEventType>()
          .map((a) => a.toAggregateEventTemplate(name))
          .toList(),
      values: inference
          .annotationsOf<AggregateValueType>()
          .map((a) => a.toAggregateValueTemplate(name))
          .toList(),
      states: inference
          .annotationsOf<AggregateStateType>()
          .map((a) => a.toAggregateStateTemplate(name, inference))
          .toList(),
    );
  }

  AggregateEventTemplate toAggregateEventTemplate(String aggregate) {
    return AggregateEventTemplate(
      name: annotationOf,
      aggregate: aggregate,
      usesJsonSerializable: usesJsonSerializable,
      data: (this['data'] as ParameterizedTypeModel).value,
    );
  }

  AggregateValueTemplate toAggregateValueTemplate(String aggregate) {
    return AggregateValueTemplate(
      name: annotationOf,
      aggregate: aggregate,
      usesJsonSerializable: usesJsonSerializable,
      data: (this['data'] as ParameterizedTypeModel).value,
    );
  }

  AggregateStateTemplate toAggregateStateTemplate(
    String aggregate,
    InferenceModel inference,
  ) {
    final events = inference
        .annotationsOf<AggregateEventType>()
        .map((a) => a.toAggregateEventTemplate(aggregate))
        .toList();
    final event = inference.firstAnnotationOf<AggregateEventType>(aggregate);
    return AggregateStateTemplate(
      events: events,
      name: annotationOf,
      aggregate: aggregate,
      value: (this['value'] as ParameterizedTypeModel).value,
      event: event?.usesJsonSerializable == true ? 'JsonObject' : 'Object',
      usesJsonSerializable:
          usesJsonSerializable || events.any((e) => e.usesJsonSerializable),
    );
  }
}

extension DartTypeX on DartType {
  String toTypeName() {
    return alias?.element.name ?? getDisplayString(withNullability: false);
  }
}

extension DartObjectX on DartObject {
  String toTypeName(String field) {
    return getField(field)!.toTypeValue()!.toTypeName();
  }
}

extension ConstantReaderX on ConstantReader {
  DartType? toFieldType(String field, [String defaultName = 'Object']) {
    return read('value').isNull ? null : read('value').typeValue;
  }

  ParameterizedTypeModel toTypeModel(String field,
          [String defaultName = 'Object']) =>
      ParameterizedTypeModel(field, toFieldTypeName(field, defaultName));

  String toFieldTypeName(String field, [String defaultName = 'Object']) {
    return read(field).toTypeName(defaultName);
  }

  String toTypeName([String defaultName = 'Object']) {
    return isNull ? defaultName : typeValue.toTypeName();
  }
}

extension ElementAnnotationX on ElementAnnotation {
  String toTypeName(String field) {
    return computeConstantValue()!.toTypeName(field);
  }

  DartType toType(String field) {
    return computeConstantValue()!.getField(field)!.toTypeValue()!;
  }
}

extension ListElementAnnotationX on List<ElementAnnotation> {
  bool usesJsonSerializable() => any(
      (e) => e.computeConstantValue()?.type.toString() == 'JsonSerializable');
}
