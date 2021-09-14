import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/inference.dart';

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
    Eventuous eventuous,
    Element element,
    ElementAnnotation annotation,
  ) {
    final name = element.displayName;
    final library = element.library!;
    final aggregate = annotation
        .computeConstantValue()!
        .getField('aggregate')!
        .toTypeValue()!
        .toTypeName();
    final values = library
        .whereAggregateValueClasses(aggregate)
        .map((c) => c.toAggregateValueTemplate(eventuous, aggregate)!)
        .toList();
    final events = library
        .whereAggregateEventClasses(aggregate)
        .map((c) => c.toAggregateEventTemplate(eventuous, aggregate)!)
        .toList();

    return AggregateStateTemplate(
      name: name,
      events: events,
      aggregate: aggregate,
      event: inferTEvent(eventuous, element, annotation, events),
      value: inferTValue(
        eventuous,
        element,
        annotation.computeConstantValue()!.getField('value')!.toTypeValue(),
        aggregate,
        values,
      ),
      usesJsonSerializable: events.any((e) => e.usesJsonSerializable),
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
