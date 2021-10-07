import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';
import '../builders/models/inference_model.dart';
import '../builders/models/parameterized_type_model.dart';

class AggregateCommandTemplate {
  AggregateCommandTemplate({
    required this.name,
    required this.data,
    required this.aggregate,
    required this.usesJsonSerializable,
  });

  factory AggregateCommandTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final aggregate = annotation.toFieldTypeName('aggregate');
    final command =
        inference.firstAnnotationOf<AggregateCommandType>(aggregate)!;
    return AggregateCommandTemplate(
      name: name,
      aggregate: aggregate,
      data: (command['data'] as ParameterizedTypeModel).value,
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
    buffer.writeln(toAggregateCommandString());
    return buffer.toString();
  }

  String toAggregateCommandString() {
    return '''
abstract class _\$$name${withJsonObject ? ' extends JsonObject' : ''}{
  _\$$name(List<Object?> props)${withJsonObject ? ' : super(props)' : ''};

  ${usesJsonSerializable ? toAggregateJsonString() : ''}
}
''';
  }

  String toAggregateJsonString() {
    return '''
// ignore: unused_element
static $name fromJson($data json) => _\$${name}FromJson(json);

@override
JsonMap toJson() => _\$${name}ToJson(this as $name);  
''';
  }
}
