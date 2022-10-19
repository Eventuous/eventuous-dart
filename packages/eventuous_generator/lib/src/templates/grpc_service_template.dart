import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/element_model.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:eventuous_generator/src/templates/aggregate_command_template.dart';
import 'package:eventuous_generator/src/templates/aggregate_id_template.dart';
import 'package:eventuous_generator/src/templates/aggregate_state_template.dart';
import 'package:path/path.dart' as p;

import '../extensions.dart';

class GrpcServiceTemplate {
  GrpcServiceTemplate({
    required this.id,
    required this.name,
    required this.data,
    required this.event,
    required this.value,
    required this.state,
    required this.appLoc,
    required this.config,
    required this.commands,
    required this.aggregate,
  });

  final String name;
  final String data;
  final String event;
  final String value;
  final String appLoc;
  final String aggregate;
  final AggregateIdTemplate id;
  final Map<String, Object?> config;
  final AggregateStateTemplate state;
  final List<AggregateCommandTemplate> commands;

  factory GrpcServiceTemplate.from(
    Map<String, Object?> config,
    InferenceModel inference,
    String annotationOf,
    String aggregate,
  ) {
    final id = inference.firstAnnotationOf<AggregateIdType>(aggregate);
    final app = inference.firstAnnotationOf<ApplicationType>(aggregate);
    final state = inference.firstAnnotationOf<AggregateStateType>(aggregate);
    final commands = inference
        .annotationsOf<AggregateCommandType>(aggregate)
        .map((a) => a.toAggregateCommandTemplate(inference))
        .toList();
    final events = inference
        .annotationsOf<AggregateEventType>()
        .map((a) => a.toAggregateEventTemplate())
        .toList();
    final value = inference.firstAnnotationOf<AggregateValueType>(aggregate);
    final event = inference.firstAnnotationOf<AggregateEventType>(aggregate);

    final grpc = inference.firstAnnotationOf<GrpcServiceType>(annotationOf);

    return GrpcServiceTemplate(
      config: config,
      name: grpc!.annotationOf,
      commands: commands,
      aggregate: aggregate,
      appLoc: app!.location!,
      data: grpc.valueAt('data'),
      event: grpc.valueAt('event'),
      value: grpc.valueAt('value'),
      id: AggregateIdTemplate(
        aggregate: aggregate,
        query: id?.valueAt('query') == 'true',
        name: id?.annotationOf ?? grpc.valueAt('id'),
      ),
      state: AggregateStateTemplate(
        name: state!.annotationOf,
        events: events,
        aggregate: aggregate,
        value: state.valueAt('value'),
        getters: value?.elementAt('getters'),
        query: state.valueAt('query') == 'true',
        event: event?.usesJsonSerializable == true ? 'JsonObject' : 'Object',
        usesJsonSerializable: state.usesJsonSerializable ||
            events.any((e) => e.usesJsonSerializable),
      ),
    );
  }

  String toImportString() => '''
// The following imports must be added $appLoc:
//
// import '$rootPath/generated/${p.basenameWithoutExtension(appLoc)}.pbgrpc.dart';
// import '$rootPath/generated/google/protobuf/empty.pb.dart';
//''';

  String get rootPath => 'TODO: rootPath';

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toImportString());
    buffer.writeln(toCommandServiceString());
    buffer.writeln(toQueryServiceString());
    return buffer.toString();
  }

  String toCommandServiceString() {
    return '''class _\$${aggregate}GrpcCommandService extends ${aggregate}GrpcCommandServiceBase {
  _\$${aggregate}GrpcCommandService(this.app);

  final ${aggregate}App app;
  
${commands.map(toCommandMethod).join('\n\n')}
  
  T _toCommandError<T>(
      ServiceCall call,
      ${aggregate}Error error,
      T Function(int code, String phrase) create,
      ) {
    toError(int code, String phrase) {
      call.sendTrailers(status: code, message: phrase);
      return create(code, phrase);
    }
    switch (error.cause) {
      case StreamNotFoundException:
        return toError(404, error.cause.toString());
      case AggregateNotFoundException:
        return toError(404, '$aggregate \${error.aggregate?.id} not found');
      case AggregateExistsException:
        return toError(409, '$aggregate \${error.aggregate?.id} exists');
      case ConcurrentModificationException:
        return toError(409, 'Concurrent modification');
    }
    return toError(500, 'Internal error: \${error.cause.toString()}');
  }
}
''';
  }

  String toQueryServiceString() {
    return '''class _\$${aggregate}GrpcQueryService extends ${aggregate}GrpcQueryServiceBase {
  _\$${aggregate}GrpcQueryService(this.app);

  final ${aggregate}App app; ${[
      id.query ? _toAggregateIdQuery() : '',
      state.query ? _toAggregateStateQuery() : '',
      _toAggregateSubscribeToQuery(),
    ].join('\n')}  
  
}''';
  }

  String _toAggregateIdQuery() {
    return '''
  @override
  Stream<${id.name}Event> get${id.name}s(ServiceCall call, Empty request) {
    // TODO: implement get${id.name}s
    throw UnimplementedError();
  }''';
  }

  String _toAggregateStateQuery() {
    return '''
  @override
  Future<${state.name}Response> get${state.name}(
      ServiceCall call,
      ${state.name}Request request,
      ) async {
    try {
      final result = await app.store.load(${id.name}(request.id));
      return ${state.name}Response()
        ..state = ${_toProtoMessage(state.getters, '${state.name}Response_${state.name}', 'result')};
    } on AggregateNotFoundException catch (e) {
      return ${state.name}Response()
        ..error = ${state.name}Response_Error(
          statusCode: 404,
          reasonPhrase: e.message,
        );
    }
  }''';
  }

  String _toAggregateSubscribeToQuery() {
    return '''
  @override
  Stream<${aggregate}Event> subscribeTo${aggregate}Events(
       ServiceCall call, SubscribeTo${aggregate}EventsRequest request) {
     // TODO: implement subscribeTo${aggregate}Events
     throw UnimplementedError();
  }''';
  }

  // outputs 'field: request.field' for named
  // and request.field on positional arguments
  String _toProtoMessage(
      ElementModel model, String messagePrefix, String fieldPrefix) {
    final fields = model.items
        .map((e) => '${e.name}: ${e.isExtrinsic
            // Must be nested message type (see protobuf_generator)
            ? _toProtoMessage(e.archetype!, '${messagePrefix}_${e.unsafeType}', '$fieldPrefix.${e.name}${e.isUnsafe ? '?' : ''}')
            // Intrinsic protobuf type
            : '$fieldPrefix.${e.name}'}')
        .join(',');
    return '''$messagePrefix($fields,)''';
  }

  String toCommandMethod(AggregateCommandTemplate command) {
    return '''
  @override
  Future<${command.name}Response> execute${command.name}(
      ServiceCall call,
      ${command.name}Request request,
      ) async {
    final result = await app.${command.name.toMemberCase()}(
      ${command.event.constructor.toInvocationArgumentsString(
      use: command.event.constructor.items.fold(
          // outputs 'field: request.field' for named
          // and request.field on positional arguments
          {}, (use, e) => use..putIfAbsent(e.name, () => 'request.${e.name}')),
    )},
    );
    return result is ${aggregate}Error
        ? (${command.name}Response()
          ..error = _toCommandError(
              call,
              result,
              (code, phrase) => ${command.name}Response_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (${command.name}Response()
      ..success = ${command.name}Response_Success());
  }
''';
  }
}
