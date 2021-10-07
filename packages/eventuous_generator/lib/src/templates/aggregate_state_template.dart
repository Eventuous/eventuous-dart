import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:eventuous_generator/src/builders/models/parameterized_type_model.dart';

import '../extensions.dart';
import 'aggregate_event_template.dart';

class AggregateStateTemplate {
  AggregateStateTemplate({
    required this.name,
    required this.event,
    required this.value,
    required this.events,
    required this.aggregate,
    required this.usesJsonSerializable,
  });

  factory AggregateStateTemplate.from(
    InferenceModel inference,
    Element element,
    ElementAnnotation annotation,
  ) {
    final aggregate = annotation.toTypeName('aggregate');
    final inferred = inference.firstAnnotationOf<AggregateType>(aggregate)!;
    final events = inference
        .annotationsOf<AggregateEventType>(aggregate)
        .map((a) => a.toAggregateEventTemplate(aggregate))
        .toList();

    return AggregateStateTemplate(
      name: element.displayName,
      events: events,
      aggregate: aggregate,
      event: (inferred['event'] as ParameterizedTypeModel).value,
      value: (inferred['value'] as ParameterizedTypeModel).value,
      usesJsonSerializable: inferred.usesJsonSerializable ||
          events.any((e) => e.usesJsonSerializable),
    );
  }

  final String name;
  final String event;
  final String value;
  final String aggregate;
  final bool usesJsonSerializable;
  final List<AggregateEventTemplate> events;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toAggregateStateString());
    return buffer.toString();
  }

  String toAggregateStateString() {
    return '''
abstract class _\$$name extends AggregateState<$value>{
  _\$$name($value? value, int? version) : super(value ?? $value(), version)${_toAggregatePatchString()}
}
''';
  }

  String toDefineAggregateStateTypeString() {
    return '''
$AggregateStateTypes.define<$value, $name>(
  ([value, version]) => $name(value, version),
);''';
  }

  String _toAggregatePatchString() {
    return usesJsonSerializable && events.isNotEmpty
        ? '''{
    ${events.map((e) => e.toAggregateEventPatchString()).join('\n')}
  }
  ${toAggregateEventPatchMethodString()}  
  '''
        : ';';
  }

  String toAggregateEventPatchMethodString() {
    return '''
$name patch($event event, $value value) {
  return $name(_\$$value.fromJson(JsonUtils.patch(
    value,
    event,
  )));
}
''';
  }
}
