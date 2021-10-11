import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';
import '../extensions.dart';
import '../helpers.dart';
import 'aggregate_command_template.dart';

class ApplicationTemplate {
  ApplicationTemplate({
    required this.id,
    required this.name,
    required this.data,
    required this.event,
    required this.value,
    required this.state,
    required this.commands,
    required this.aggregate,
  });

  factory ApplicationTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = annotation.toFieldTypeName('aggregate');
    final application = inference.firstAnnotationOf<ApplicationType>(name);
    final commands = inference
        .annotationsOf<AggregateCommandType>(name)
        .map((a) => a.toAggregateCommandTemplate(inference))
        .toList();

    return ApplicationTemplate(
      aggregate: name,
      commands: commands,
      name: element.displayName,
      data: parameterTypeAt('data', application, annotation),
      event: parameterTypeAt('event', application, annotation),
      id: parameterTypeAt('id', application, annotation, '${name}Id'),
      value: parameterTypeAt('value', application, annotation, '${name}Value'),
      state: parameterTypeAt('state', application, annotation, '${name}State'),
    );
  }

  final String id;
  final String name;
  final String data;
  final String event;
  final String value;
  final String state;
  final String aggregate;
  final List<AggregateCommandTemplate> commands;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toApplicationTypeDefsString());
    buffer.writeln(toApplicationString());
    return buffer.toString();
  }

  String toApplicationString() {
    return '''
abstract class _\$$name extends ApplicationServiceBase<$data,
    $event,$value,$id,$state,$aggregate>{
  _\$$name(${aggregate}Store store) : super(store) {
    ${commands.map((e) => e.toAggregateCommandHandlerString(id)).join('\n')}  
  }
  ${commands.map((e) => toAggregateCommandMethodString(e)).join('\n')}
}
''';
  }

  String toAggregateCommandMethodString(AggregateCommandTemplate template) {
    final arguments = template.constructor.toArgumentsDeclarationString();
    // TODO: Support AggregateIdField to indicate id-field in commands and events
    // TODO: Support mapping between with @AggregateEventField(name:'something') on command fields
    final invocation = template.event.constructor.toArgumentsInvocationString();
    return '''FutureOr<${aggregate}Result> ${template.name.toMemberCase()}($arguments){
  return handle(${template.name}($invocation));
}''';
  }

  String toApplicationTypeDefsString() {
    return '''
typedef ${aggregate}Result = AggregateCommandResult<$event,$value,$id,$state,
  $aggregate>;

typedef ${aggregate}Ok = AggregateCommandOkResult<$event,$value,$id,$state,
  $aggregate>;

typedef ${aggregate}Error = AggregateCommandErrorResult<$event,$value,$id,
  $state,$aggregate>;
''';
  }
}
