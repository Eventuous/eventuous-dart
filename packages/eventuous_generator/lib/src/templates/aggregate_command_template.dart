import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/annotation_model.dart';
import 'package:eventuous_generator/src/builders/models/element_model.dart';
import 'package:eventuous_generator/src/builders/models/parameter_model.dart';
import 'package:eventuous_generator/src/templates/aggregate_event_template.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';
import '../builders/models/inference_model.dart';
import '../helpers.dart';

class AggregateCommandTemplate {
  AggregateCommandTemplate({
    required this.name,
    required this.data,
    required this.event,
    required this.aggregate,
    required this.constructor,
    required this.usesJsonSerializable,
    this.expected = ExpectedState.any,
  });

  factory AggregateCommandTemplate.from(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final aggregate = annotation.toFieldTypeName('aggregate');
    final command =
        inference.firstAnnotationOf<AggregateCommandType>(aggregate);
    final expected = parameterExpectedStateAt(
      'expected',
      annotation,
      model: command,
    );
    final data = fieldTypeNameAt('data', command, annotation);
    final event = fieldTypeNameAt('event', command, annotation);

    return AggregateCommandTemplate(
      name: name,
      data: data,
      expected: expected,
      aggregate: aggregate,
      constructor: element.toConstructorModel(),
      event: inference
          .where<AggregateEventType>(aggregate)
          .firstWhere(
            (e) => e.annotationOf == event,
            orElse: () => AnnotationModel(
              '$AggregateEventType',
              event,
              parameters: [
                element.toConstructorModel(),
                ParameterModel('aggregate', aggregate),
                command?.typedAt<ParameterModel>('data') ??
                    ParameterModel('data', data),
              ],
            ),
          )
          .toAggregateEventTemplate(),
      usesJsonSerializable:
          command?.usesJsonSerializable ?? element.usesJsonSerializable,
    );
  }

  final String name;
  final String data;
  final String aggregate;
  final ExpectedState expected;
  final ElementModel constructor;
  final bool usesJsonSerializable;
  final AggregateEventTemplate event;

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
    buffer.writeln(toAggregateCommandClassString());
    return buffer.toString();
  }

  String toAggregateCommandClassString() {
    return '''
abstract class _\$$name${withJsonObject ? ' extends JsonObject' : ''}{
  _\$$name(List<Object?> props)${withJsonObject ? ' : super(props)' : ''};

  ${usesJsonSerializable ? toAggregateCommandJsonString() : ''}
}
''';
  }

  String toAggregateCommandJsonString() {
    return '''
// ignore: unused_element
static $name fromJson($data json) => _\$${name}FromJson(json);

@override
JsonMap toJson() => _\$${name}ToJson(this as $name);  
''';
  }

  String toAggregateCommandHandlerString(String tid) {
    final _aggregate = aggregate.toMemberCase();
    final methodArgs = constructor.toInvocationArgumentsString(
      where: (e) => '${_aggregate}Id' != e.name,
      use: constructor.items.fold(
          {}, (use, e) => use..putIfAbsent(e.name, () => 'cmd.${e.name}')),
    );

    return '''
$_on<$name>(
  (cmd) => $tid(cmd.${_aggregate}Id),
  (cmd, $_aggregate) => $_aggregate.${name.toMemberCase()}($methodArgs),
);
''';
  }

  String get _on {
    switch (expected) {
      case ExpectedState.notExists:
        return 'onNew';
      case ExpectedState.exists:
        return 'onExisting';
      case ExpectedState.any:
        return 'onAny';
    }
  }
}
