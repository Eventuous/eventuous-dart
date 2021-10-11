import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:eventuous_generator/src/builders/models/method_model.dart';
import 'package:eventuous_generator/src/helpers.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'builders/models/annotation_model.dart';
import 'builders/models/parameter_model.dart';
import 'templates/aggregate_command_template.dart';
import 'templates/aggregate_event_template.dart';
import 'templates/aggregate_state_template.dart';
import 'templates/aggregate_template.dart';
import 'templates/aggregate_value_template.dart';
import 'templates/application_template.dart';

extension StringX on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
  String toMemberCase() => '${this[0].toLowerCase()}${substring(1)}';
}

extension AnnotationModelX on AnnotationModel {
  ApplicationTemplate toApplicationTemplate(
    InferenceModel inference,
  ) {
    final aggregate = parameterValueAt('aggregate');
    final commands = inference
        .annotationsOf<AggregateCommandType>(aggregate)
        .map((a) => a.toAggregateCommandTemplate(inference))
        .toList();

    return ApplicationTemplate(
      name: annotationOf,
      commands: commands,
      aggregate: aggregate,
      id: parameterValueAt('id'),
      data: parameterValueAt('data'),
      event: parameterValueAt('event'),
      value: parameterValueAt('value'),
      state: parameterValueAt('state'),
    );
  }

  AggregateTemplate toAggregateTemplate(
    InferenceModel inference,
  ) {
    final commands = inference
        .annotationsOf<AggregateCommandType>(annotationOf)
        .map((a) => a.toAggregateCommandTemplate(inference))
        .toList();

    return AggregateTemplate(
      name: annotationOf,
      commands: commands,
      id: parameterValueAt('id'),
      data: parameterValueAt('data'),
      event: parameterValueAt('event'),
      value: parameterValueAt('value'),
      state: parameterValueAt('state'),
    );
  }

  AggregateCommandTemplate toAggregateCommandTemplate(
      InferenceModel inference) {
    final event = parameterValueAt('event');
    final expected = parameterValueAt('expected');
    final aggregate = parameterValueAt('aggregate');
    return AggregateCommandTemplate(
      name: annotationOf,
      aggregate: aggregate,
      data: parameterValueAt('data'),
      event: inference
          .where<AggregateEventType>(aggregate)
          .firstWhere(
            (e) => e.annotationOf == event,
            orElse: () => AnnotationModel(
              '$AggregateEventType',
              event,
              parameters: [
                elementAt<ParameterModel>('data'),
                ParameterModel('aggregate', aggregate),
                elementAt<ParameterModel>('constructor'),
              ],
            ),
          )
          .toAggregateEventTemplate(),
      constructor: methodAt('constructor'),
      usesJsonSerializable: usesJsonSerializable,
      expected: ExpectedState.values.firstWhere((e) => enumName(e) == expected,
          orElse: () => ExpectedState.any),
    );
  }

  AggregateEventTemplate toAggregateEventTemplate() {
    return AggregateEventTemplate(
      name: annotationOf,
      data: parameterValueAt('data'),
      constructor: methodAt('constructor'),
      aggregate: parameterValueAt('aggregate'),
      usesJsonSerializable: usesJsonSerializable,
    );
  }

  AggregateValueTemplate toAggregateValueTemplate() {
    return AggregateValueTemplate(
      name: annotationOf,
      data: parameterValueAt('data'),
      aggregate: parameterValueAt('aggregate'),
      usesJsonSerializable: usesJsonSerializable,
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
      value: parameterValueAt('value'),
      event: event?.usesJsonSerializable == true ? 'JsonObject' : 'Object',
      usesJsonSerializable:
          usesJsonSerializable || events.any((e) => e.usesJsonSerializable),
    );
  }
}

extension DartTypeX on DartType {
  String toTypeName() {
    final type = alias?.element.name ?? getDisplayString(withNullability: true);
    return type.endsWith('*') ? type.substring(0, type.length - 1) : type;
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

  DartObject? toFieldObject(String field) {
    final reader = peek(field);
    return reader == null || reader.isNull ? null : reader.objectValue;
  }

  ParameterModel toTypeModel(String field, [String defaultName = 'Object']) =>
      ParameterModel(field, toFieldTypeName(field, defaultName));

  ParameterModel toExpectedStateModel(String field) {
    return ParameterModel(
      field,
      enumName(parameterExpectedStateAt(field, this)),
    );
  }

  String toFieldTypeName(String field, [String defaultName = 'Object']) {
    return toFieldType(field)?.toTypeName() ?? defaultName;
  }
}

const _jsonSerializableChecker = TypeChecker.fromRuntime(JsonSerializable);

extension ElementX on Element {
  bool get usesJsonSerializable =>
      _jsonSerializableChecker.hasAnnotationOfExact(this);
}

extension ClassElementX on ClassElement {
  MethodModel toConstructorArgumentsModel() {
    // TODO: Validate constructor
    return MethodModel.from('constructor', constructors.first);
  }
}
