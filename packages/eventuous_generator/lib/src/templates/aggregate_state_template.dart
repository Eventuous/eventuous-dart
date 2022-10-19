import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/element_model.dart';
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
    required this.query,
    required this.events,
    required this.aggregate,
    required ElementModel? getters,
    required this.usesJsonSerializable,
  }) : getters = getters ?? ElementModel('getters', []);

  factory AggregateStateTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final query = annotation.toFieldBool('query');
    final aggregate = annotation.toFieldTypeName('aggregate');
    final model = inference.firstAnnotationOf<AggregateType>(aggregate);
    final value = inference.firstAnnotationOf<AggregateValueType>(aggregate);
    final events = inference
        .annotationsOf<AggregateEventType>(aggregate)
        .map((a) => a.toAggregateEventTemplate())
        .toList();

    return AggregateStateTemplate(
      name: name,
      events: events,
      aggregate: aggregate,
      query: query == true,
      getters: value?.elementAt('getters'),
      usesJsonSerializable: element.usesJsonSerializable,
      event: fieldTypeNameAt('event', model, annotation),
      value: fieldTypeNameAt('value', model, annotation, '${aggregate}Value'),
    );
  }

  final bool query;
  final String name;
  final String event;
  final String value;
  final String aggregate;
  final ElementModel getters;
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

  ${toAggregateValueGettersString()}

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
        ? events.map((e) => e.toAggregateEventPatchString()).join('\n')
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

  String toAggregateValueGettersString() {
    return getters
        .toInvocationGettersString(
          invoke: (name) => 'value.$name',
        )
        .join('\n');
  }
}
