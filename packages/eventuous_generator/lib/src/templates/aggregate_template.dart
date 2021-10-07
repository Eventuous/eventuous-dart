import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/parameterized_type_model.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';
import '../builders/models/inference_model.dart';
import 'aggregate_event_template.dart';
import 'aggregate_state_template.dart';
import 'aggregate_value_template.dart';

class AggregateTemplate {
  AggregateTemplate({
    required this.id,
    required this.name,
    required this.event,
    required this.value,
    required this.state,
    this.events = const [],
    this.states = const [],
    this.values = const [],
  });

  factory AggregateTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final aggregate = inference.firstAnnotationOf<AggregateType>(name)!;
    final events = inference
        .annotationsOf<AggregateEventType>(name)
        .map((a) => a.toAggregateEventTemplate(name))
        .toList();
    final values = inference
        .annotationsOf<AggregateValueType>(name)
        .map((a) => a.toAggregateValueTemplate(name))
        .toList();
    final states = inference
        .annotationsOf<AggregateStateType>(name)
        .map((a) => a.toAggregateStateTemplate(name, inference))
        .toList();

    return AggregateTemplate(
      name: name,
      events: events,
      values: values,
      states: states,
      id: annotation.toFieldTypeName('id', '${name}Id'),
      event: (aggregate['event'] as ParameterizedTypeModel).value,
      value: (aggregate['value'] as ParameterizedTypeModel).value,
      state: (aggregate['state'] as ParameterizedTypeModel).value,
    );
  }

  final String id;
  final String name;
  final String event;
  final String value;
  final String state;

  final List<AggregateEventTemplate> events;
  final List<AggregateValueTemplate> values;
  final List<AggregateStateTemplate> states;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toAggregateString());
    buffer.writeln(toDefineAggregateTypesString());
    return buffer.toString();
  }

  String toAggregateString() {
    return '''
abstract class _\$$name extends Aggregate<$event,$value,$id,$state>{
  _\$$name($id id, $state? state) : super(id, state ?? $state());
  // ignore: unused_element
  static $name from(String id) => $name($id(id));
}
  ${values.map((e) => e.toAggregateValueString()).join('\n')}
  ${states.map((e) => e.toAggregateStateString()).join('\n')}
  ${events.map((e) => e.toAggregateEventString()).join('\n')}
''';
  }

  String toDefineAggregateTypesString() {
    return '''
void define${name}Types() {
  $AggregateTypes.define<$event,$value,$id,$state,$name>(
    (id, [state]) => $name(id, state));
  ${states.map((e) => e.toDefineAggregateStateTypeString()).join('\n')}
  ${events.map((e) => e.toDefineAggregateEventTypeString()).join('\n')}
}    
''';
  }

  String toDefineAggregateTypesMethodString() => 'void define${name}Types();';
}
