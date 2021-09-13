import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_annotation/eventuous_annotation.dart';

import '../extensions.dart';
import '../inference.dart';

class AggregateValueTemplate {
  AggregateValueTemplate({
    required this.name,
    required this.data,
    required this.aggregate,
    required this.usesJsonSerializable,
  });

  factory AggregateValueTemplate.from(
    Eventuous eventuous,
    Element element,
    ElementAnnotation annotation,
  ) {
    final name = element.displayName;
    final aggregate = annotation.computeConstantValue()!.getField('aggregate')!;

    return AggregateValueTemplate(
      name: name,
      aggregate: aggregate.toTypeValue()!.toTypeName(),
      data: inferTData(eventuous, element, annotation),
      usesJsonSerializable: element.metadata.usesJsonSerializable(),
    );
  }

  final String name;
  final String data;
  final String aggregate;
  final bool usesJsonSerializable;
  bool get withJsonObject =>
      usesJsonSerializable ||
      const [
        'JsonMap',
        'Map',
        'Map<String,dynamic>',
      ].contains(data);

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toAggregateValueString());
    return buffer.toString();
  }

  String toAggregateValueString() {
    return '''
abstract class _\$$name${withJsonObject ? ' extends JsonObject' : ''}{
  _\$$name(List<Object?> props)${withJsonObject ? ' : super(props)' : ''};
  
  ${usesJsonSerializable ? toAggregateJsonString() : ''}
}
''';
  }

  String toAggregateJsonString() {
    return '''
static $name fromJson($data json) => _\$${name}FromJson(json);

@override
JsonMap toJson() => _\$${name}ToJson(this as $name);  
''';
  }
}
