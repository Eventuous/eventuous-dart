import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';
import '../helpers.dart';

class AggregateTemplate {
  AggregateTemplate({
    required this.id,
    required this.name,
    required this.event,
    required this.value,
    required this.state,
  });

  factory AggregateTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final aggregate = inference.firstAnnotationOf<AggregateType>(name);

    return AggregateTemplate(
      name: name,
      id: parameterValueAt('id', aggregate, annotation, '${name}Id'),
      event: parameterValueAt('event', aggregate, annotation),
      value: parameterValueAt('value', aggregate, annotation, '${name}Value'),
      state: parameterValueAt('state', aggregate, annotation, '${name}State'),
    );
  }

  final String id;
  final String name;
  final String event;
  final String value;
  final String state;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toAggregateString());
    return buffer.toString();
  }

  String toAggregateString() {
    return '''
abstract class _\$$name extends Aggregate<$event,$value,$id,$state>{
  _\$$name($id id, $state? state) : super(id, state ?? $state()) {
    ${toDefineAggregateTypeString()}
  }
  // ignore: unused_element
  static $name from(String id) => $name($id(id));
}
''';
  }

  String toDefineAggregateTypeString() {
    return '''
$AggregateTypes.define<$event,$value,$id,$state,$name>(
  (id, [state]) => $name(id, state),
);''';
  }
}
