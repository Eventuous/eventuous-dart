import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';
import '../extensions.dart';
import '../helpers.dart';
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
    ConstantReader annotation,
  ) {
    final aggregate = annotation.toFieldTypeName('aggregate');
    final state = inference.firstAnnotationOf<AggregateType>(aggregate);
    final events = inference
        .annotationsOf<AggregateEventType>(aggregate)
        .map((a) => a.toAggregateEventTemplate())
        .toList();

    return AggregateStateTemplate(
      name: element.displayName,
      events: events,
      aggregate: aggregate,
      event: parameterValueAt('event', state, annotation),
      value: parameterValueAt('value', state, annotation, '${aggregate}Value'),
      usesJsonSerializable:
          (state?.usesJsonSerializable ?? element.usesJsonSerializable) ||
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
  _\$$name($value? value, int? version) : super(value ?? $value(), version){
    ${toDefineAggregateStateTypeString()}
    ${_toAggregatePatchString()}
  }
    
  ${toAggregateEventPatchMethodString()}
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
        ? '''${events.map((e) => e.toAggregateEventPatchString()).join('\n')}'''
        : '';
  }

  String toAggregateEventPatchMethodString() {
    return '''
$name patch($event event, $value value) {
  return $name($AggregateValueTypes.create<JsonMap, $value>(
    JsonUtils.patch(
      value,
      event,
    ),
  ));
}
''';
  }
}
