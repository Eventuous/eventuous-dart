import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:json_annotation/json_annotation.dart';
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
    );
  }

  AggregateEventTemplate toAggregateEventTemplate() {
    return AggregateEventTemplate(
      name: annotationOf,
      aggregate: parameterValueAt('aggregate'),
      usesJsonSerializable: usesJsonSerializable,
      data: (this['data'] as ParameterizedTypeModel).value,
    );
  }

  AggregateValueTemplate toAggregateValueTemplate() {
    return AggregateValueTemplate(
      name: annotationOf,
      aggregate: parameterValueAt('aggregate'),
      usesJsonSerializable: usesJsonSerializable,
      data: (this['data'] as ParameterizedTypeModel).value,
    );
  }

  AggregateStateTemplate toAggregateStateTemplate(
    InferenceModel inference,
  ) {
    final aggregate = parameterValueAt('aggregate');
    final events = inference
        .annotationsOf<AggregateEventType>()
        .map((a) => a.toAggregateEventTemplate())
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
  DartType? toFieldType(String field) {
    final reader = peek(field);
    return reader == null || reader.isNull ? null : reader.typeValue;
  }

  ParameterizedTypeModel toTypeModel(String field,
          [String defaultName = 'Object']) =>
      ParameterizedTypeModel(field, toFieldTypeName(field, defaultName));

  String toFieldTypeName(String field, [String defaultName = 'Object']) {
    return toFieldType(field)?.toTypeName() ?? defaultName;
  }
}

const _jsonSerializableChecker = TypeChecker.fromRuntime(JsonSerializable);

extension ElementX on Element {
  bool get usesJsonSerializable =>
      _jsonSerializableChecker.hasAnnotationOfExact(this);
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
