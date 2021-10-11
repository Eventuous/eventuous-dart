import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';
import '../extensions.dart';
import '../helpers.dart';
import 'aggregate_command_template.dart';

class AggregateTemplate {
  AggregateTemplate({
    required this.id,
    required this.name,
    required this.data,
    required this.event,
    required this.value,
    required this.state,
    required this.commands,
  });

  factory AggregateTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final aggregate = inference.firstAnnotationOf<AggregateType>(name);
    final commands = inference
        .annotationsOf<AggregateCommandType>(name)
        .map((a) => a.toAggregateCommandTemplate(inference))
        .toList();

    return AggregateTemplate(
      name: name,
      commands: commands,
      data: parameterTypeAt('data', aggregate, annotation),
      event: parameterTypeAt('event', aggregate, annotation),
      id: parameterTypeAt('id', aggregate, annotation, '${name}Id'),
      value: parameterTypeAt('value', aggregate, annotation, '${name}Value'),
      state: parameterTypeAt('state', aggregate, annotation, '${name}State'),
    );
  }

  final String id;
  final String name;
  final String data;
  final String event;
  final String value;
  final String state;
  final List<AggregateCommandTemplate> commands;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toAggregateTypeDefsString());
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
  
  ${commands.map((e) => toAggregateCommandMethodString(e)).join('\n')}
}
''';
  }

  String toAggregateCommandMethodString(AggregateCommandTemplate template) {
    final idName = '${name}Id'.toMemberCase();
    final methodArgs = template.constructor.toArgumentsDeclarationString(
      (e) => e.name != idName,
    );
    final eventArgs = template.constructor.toArgumentsInvocationString(
      use: {'$idName': 'id.value'},
    );
    return '''${state}Result ${template.name.toMemberCase()}($methodArgs){
  ${_assert(template)}
  return apply(${template.event.name}($eventArgs));
}''';
  }

  String _assert(AggregateCommandTemplate template) {
    switch (template.expected) {
      case ExpectedState.notExists:
        return 'ensureDoesntExists();';
      case ExpectedState.exists:
        return 'ensureExists();';
      case ExpectedState.any:
      default:
        return '';
    }
  }

  String toDefineAggregateTypeString() {
    return '''
$AggregateTypes.define<$event,$value,$id,$state,$name>(
  (id, [state]) => $name(id, state),
);''';
  }

  String toAggregateTypeDefsString() {
    return '''
typedef ${name}Store = AggregateStore<$data,$event,$value,$id,$state,
  $name>;

typedef ${state}Result = AggregateStateResult<$event,$value,$id,$state>;

typedef ${state}Ok = AggregateStateOk<$event,$value,$id,$state>;

typedef ${state}Error = AggregateStateError<$event,$value,$id,$state>;

typedef ${state}NoOp = AggregateStateNoOp<$event,$value,$id,$state>;    
''';
  }
}
