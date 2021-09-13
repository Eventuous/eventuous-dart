import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/inference.dart';

import '../extensions.dart';

class AggregateStateTemplate {
  AggregateStateTemplate({
    required this.name,
    required this.value,
    required this.aggregate,
  });

  factory AggregateStateTemplate.from(
    Eventuous eventuous,
    Element element,
    ElementAnnotation annotation,
  ) {
    final name = element.displayName;
    final library = element.library!;
    final values = library
        .whereAggregateValueClasses(name)
        .map((c) => c.toAggregateValueTemplate(eventuous, name)!)
        .toList();
    final type = annotation
        .computeConstantValue()!
        .getField('aggregate')!
        .toTypeValue()!
        .toTypeName();

    return AggregateStateTemplate(
      name: name,
      aggregate: type,
      value: inferTValue(
        eventuous,
        annotation.computeConstantValue()!.getField('value')!.toTypeValue(),
        type,
        values,
      ),
    );
  }

  final String name;
  final String value;
  final String aggregate;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toAggregateStateString());
    return buffer.toString();
  }

  String toAggregateStateString() {
    return '''
abstract class _\$$name extends AggregateState<$value>{
  _\$$name($value? value, int? version) : super(value ?? $value(), version);
}
''';
  }

  String toDefineAggregateStateTypeString() {
    return '''
$AggregateStateTypes.define<$value, $name>(
  ([value, version]) => $name(value, version),
);''';
  }
}
