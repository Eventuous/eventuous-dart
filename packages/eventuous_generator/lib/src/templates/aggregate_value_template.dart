import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:eventuous_generator/src/builders/models/parameterized_type_model.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';

class AggregateValueTemplate {
  AggregateValueTemplate({
    required this.name,
    required this.data,
    required this.aggregate,
    required this.usesJsonSerializable,
  });

  factory AggregateValueTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final aggregate = annotation.toFieldTypeName('aggregate');
    final inferred = inference.firstAnnotationOf<AggregateValueType>(aggregate);

    return AggregateValueTemplate(
      name: name,
      aggregate: aggregate,
      data: (inferred!['data'] as ParameterizedTypeModel).value,
      usesJsonSerializable: inferred.usesJsonSerializable,
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
  _\$$name(List<Object?> props)${withJsonObject ? ' : super(props)' : ''}{
    ${toDefineAggregateValueTypeString()}
  }
  
  ${usesJsonSerializable ? toAggregateJsonString() : ''}
}
''';
  }

  String toAggregateJsonString() {
    return '''
static $name fromJson([$data? json]) => _\$${name}FromJson(json ?? {});

@override
JsonMap toJson() => _\$${name}ToJson(this as $name);  
''';
  }

  String toDefineAggregateValueTypeString() {
    return '''
$AggregateValueTypes.define<$data, $name>(
  _\$$name.fromJson,
);''';
  }
}
