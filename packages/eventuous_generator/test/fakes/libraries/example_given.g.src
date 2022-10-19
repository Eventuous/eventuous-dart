// **************************************************************************
// GrpcServiceGenerator
// **************************************************************************

// The following imports must be added /test_lib/lib/example.dart:
//
// import 'TODO: rootPath/generated/example.pbgrpc.dart';
// import 'TODO: rootPath/generated/google/protobuf/empty.pb.dart';
//
class _$ExampleGrpcCommandService extends ExampleGrpcCommandServiceBase {
  _$ExampleGrpcCommandService(this.app);

  final ExampleApp app;

  @override
  Future<CreateExampleResponse> executeCreateExample(
    ServiceCall call,
    CreateExampleRequest request,
  ) async {
    final result = await app.createExample(
      exampleId: request.exampleId,
      title: request.title,
      author: request.author,
    );
    return result is ExampleError
        ? (CreateExampleResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => CreateExampleResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (CreateExampleResponse()..success = CreateExampleResponse_Success());
  }

  @override
  Future<UpdateExampleResponse> executeUpdateExample(
    ServiceCall call,
    UpdateExampleRequest request,
  ) async {
    final result = await app.updateExample(
      request.exampleId,
      request.title,
      request.author,
    );
    return result is ExampleError
        ? (UpdateExampleResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => UpdateExampleResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (UpdateExampleResponse()..success = UpdateExampleResponse_Success());
  }

  @override
  Future<ImportExampleResponse> executeImportExample(
    ServiceCall call,
    ImportExampleRequest request,
  ) async {
    final result = await app.importExample(
      request.exampleId,
      request.title,
      request.author,
    );
    return result is ExampleError
        ? (ImportExampleResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => ImportExampleResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (ImportExampleResponse()..success = ImportExampleResponse_Success());
  }

  T _toCommandError<T>(
    ServiceCall call,
    ExampleError error,
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
        return toError(404, 'Example ${error.aggregate?.id} not found');
      case AggregateExistsException:
        return toError(409, 'Example ${error.aggregate?.id} exists');
      case ConcurrentModificationException:
        return toError(409, 'Concurrent modification');
    }
    return toError(500, 'Internal error: ${error.cause.toString()}');
  }
}

class _$ExampleGrpcQueryService extends ExampleGrpcQueryServiceBase {
  _$ExampleGrpcQueryService(this.app);

  final ExampleApp app;

  @override
  Stream<ExampleEvent> subscribeToExampleEvents(
      ServiceCall call, SubscribeToExampleEventsRequest request) {
    // TODO: implement subscribeToExampleEvents
    throw UnimplementedError();
  }
}

// **************************************************************************
// ApplicationGenerator
// **************************************************************************

typedef ExampleResult = AggregateCommandResult<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1, Example>;

typedef ExampleOk = AggregateCommandOkResult<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1, Example>;

typedef ExampleError = AggregateCommandErrorResult<JsonObject,
    ExampleStateModel1, ExampleId1, ExampleState1, Example>;

abstract class _$ExampleApp extends ApplicationServiceBase<JsonMap, JsonObject,
    ExampleStateModel1, ExampleId1, ExampleState1, Example> {
  _$ExampleApp(ExampleStore store) : super(store) {
    onNew<CreateExample>(
      (cmd) => ExampleId1(cmd.exampleId),
      (cmd, example) =>
          example.createExample(title: cmd.title, author: cmd.author),
    );

    onExisting<UpdateExample>(
      (cmd) => ExampleId1(cmd.exampleId),
      (cmd, example) => example.updateExample(cmd.title, cmd.author),
    );

    onAny<ImportExample>(
      (cmd) => ExampleId1(cmd.exampleId),
      (cmd, example) => example.importExample(cmd.title, cmd.author),
    );
  }
  FutureOr<ExampleResult> createExample(
      {required dynamic exampleId,
      required String title,
      required String author}) {
    return handle(
        CreateExample(exampleId: exampleId, title: title, author: author));
  }

  FutureOr<ExampleResult> updateExample(
      String exampleId, String title, String? author) {
    return handle(UpdateExample(exampleId, title, author));
  }

  FutureOr<ExampleResult> importExample(String exampleId, String title,
      [String? author = 'user']) {
    return handle(ImportExample(exampleId, title, author));
  }
}

// **************************************************************************
// AggregateGenerator
// **************************************************************************

typedef ExampleStore = AggregateStore<JsonMap, JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1, Example>;

typedef ExampleState1Result = AggregateStateResult<JsonObject,
    ExampleStateModel1, ExampleId1, ExampleState1>;

typedef ExampleState1Ok = AggregateStateOk<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1>;

typedef ExampleState1Error = AggregateStateError<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1>;

typedef ExampleState1NoOp = AggregateStateNoOp<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1>;

abstract class _$Example extends Aggregate<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1> {
  _$Example(ExampleId1 id, ExampleState1? state)
      : super(id, state ?? ExampleState1()) {
    AggregateTypes.define<JsonObject, ExampleStateModel1, ExampleId1,
        ExampleState1, Example>(
      (id, [state]) => Example(id, state),
    );
  }
  // ignore: unused_element
  static Example from(String id) => Example(ExampleId1(id));

  String get title => current.title;
  String get author => current.author;

  ExampleState1Result createExample(
      {required String title, required String author}) {
    ensureDoesntExists();
    return apply(
        ExampleCreated(exampleId: id.value, title: title, author: author));
  }

  ExampleState1Result updateExample(String title, String? author) {
    ensureExists();
    return apply(ExampleUpdated(id.value, title, author));
  }

  ExampleState1Result importExample(String title, [String? author = 'user']) {
    return apply(ExampleImported(id.value, title, author));
  }
}

// **************************************************************************
// AggregateCommandGenerator
// **************************************************************************

abstract class _$CreateExample extends JsonObject {
  _$CreateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static CreateExample fromJson(JsonMap json) => _$CreateExampleFromJson(json);

  @override
  JsonMap toJson() => _$CreateExampleToJson(this as CreateExample);
}

abstract class _$UpdateExample extends JsonObject {
  _$UpdateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static UpdateExample fromJson(JsonMap json) => _$UpdateExampleFromJson(json);

  @override
  JsonMap toJson() => _$UpdateExampleToJson(this as UpdateExample);
}

abstract class _$ImportExample extends JsonObject {
  _$ImportExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static ImportExample fromJson(JsonMap json) => _$ImportExampleFromJson(json);

  @override
  JsonMap toJson() => _$ImportExampleToJson(this as ImportExample);
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _$ExampleCreated extends JsonObject {
  _$ExampleCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleCreated>(
      _$ExampleCreated.fromJson,
    );
  }

  static ExampleCreated fromJson(JsonMap json) =>
      _$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleCreatedToJson(this as ExampleCreated);
}

abstract class _$ExampleUpdated extends JsonObject {
  _$ExampleUpdated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleUpdated>(
      _$ExampleUpdated.fromJson,
    );
  }

  static ExampleUpdated fromJson(JsonMap json) =>
      _$ExampleUpdatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleUpdatedToJson(this as ExampleUpdated);
}

abstract class _$ExampleImported extends JsonObject {
  _$ExampleImported(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleImported>(
      _$ExampleImported.fromJson,
    );
  }

  static ExampleImported fromJson(JsonMap json) =>
      _$ExampleImportedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleImportedToJson(this as ExampleImported);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _$ExampleStateModel1 extends JsonObject {
  _$ExampleStateModel1(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, ExampleStateModel1>(
      _$ExampleStateModel1.fromJson,
    );
  }

  static ExampleStateModel1 fromJson([JsonMap? json]) =>
      _$ExampleStateModel1FromJson(json ?? {});

  @override
  JsonMap toJson() => _$ExampleStateModel1ToJson(this as ExampleStateModel1);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _$ExampleState1 extends AggregateState<ExampleStateModel1> {
  _$ExampleState1(ExampleStateModel1? value, int? version)
      : super(value ?? ExampleStateModel1(), version) {
    AggregateStateTypes.define<ExampleStateModel1, ExampleState1>(
      ([value, version]) => ExampleState1(value, version),
    );
  }

  String get title => value.title;
  String get author => value.author;

  ExampleState1 patch(JsonObject event, ExampleStateModel1 value) {
    return ExampleState1(
        AggregateValueTypes.create<JsonMap, ExampleStateModel1>(
      JsonUtils.patch(
        value,
        event,
      ),
    ));
  }
}
