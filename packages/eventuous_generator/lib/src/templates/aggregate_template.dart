import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_annotation/eventuous_annotation.dart';
import 'package:eventuous_generator/src/inference.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';
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
    this.commands = const [],
  });

  factory AggregateTemplate.from(
    Eventuous eventuous,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final library = element.library!;
    final values = library
        .whereAggregateValueClasses(name)
        .map((c) => c.toAggregateValueTemplate(eventuous, name)!)
        .toList();
    final states = library
        .whereAggregateStateClasses(name)
        .map((c) => c.toAggregateStateTemplate(eventuous, name)!)
        .toList();

    return AggregateTemplate(
      name: name,
      states: states,
      values: values,
      id: annotation.read('id').toTypeName('${name}Id'),
      event: annotation.read('event').toTypeName('Object'),
      value: inferTValue(
        eventuous,
        annotation.read('value').isNull
            ? null
            : annotation.read('value').typeValue,
        name,
        values,
      ),
      state: inferTState(eventuous, annotation, name, states),
      events: library
          .whereAggregateEventClasses(name)
          .map((c) => c.toAggregateEventTemplate(eventuous, name)!)
          .toList(),
      commands: library.whereAggregateCommandClasses(name).toList(),
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
  final List<ClassElement> commands;

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
}
