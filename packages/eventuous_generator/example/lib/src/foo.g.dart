// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foo.dart';

// **************************************************************************
// GrpcServiceGenerator
// **************************************************************************

// The following imports must be added /eventuous_generator/example/lib/src/foo.dart:
//
// import 'TODO: rootPath/generated/foo.pbgrpc.dart';
// import 'TODO: rootPath/generated/google/protobuf/empty.pb.dart';
//
class _$FooGrpcCommandService extends FooGrpcCommandServiceBase {
  _$FooGrpcCommandService(this.app);

  final FooApp app;

  @override
  Future<CreateFooResponse> executeCreateFoo(
    ServiceCall call,
    CreateFooRequest request,
  ) async {
    final result = await app.createFoo(
      fooId: request.fooId,
      title: request.title,
      author: request.author,
    );
    return result is FooError
        ? (CreateFooResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => CreateFooResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (CreateFooResponse()..success = CreateFooResponse_Success());
  }

  @override
  Future<UpdateFooResponse> executeUpdateFoo(
    ServiceCall call,
    UpdateFooRequest request,
  ) async {
    final result = await app.updateFoo(
      request.fooId,
      request.title,
      request.author,
    );
    return result is FooError
        ? (UpdateFooResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => UpdateFooResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (UpdateFooResponse()..success = UpdateFooResponse_Success());
  }

  @override
  Future<ImportFooResponse> executeImportFoo(
    ServiceCall call,
    ImportFooRequest request,
  ) async {
    final result = await app.importFoo(
      request.fooId,
      request.title,
      request.author,
    );
    return result is FooError
        ? (ImportFooResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => ImportFooResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (ImportFooResponse()..success = ImportFooResponse_Success());
  }

  T _toCommandError<T>(
    ServiceCall call,
    FooError error,
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
        return toError(404, 'Foo ${error.aggregate?.id} not found');
      case AggregateExistsException:
        return toError(409, 'Foo ${error.aggregate?.id} exists');
      case ConcurrentModificationException:
        return toError(409, 'Concurrent modification');
    }
    return toError(500, 'Internal error: ${error.cause.toString()}');
  }
}

class _$FooGrpcQueryService extends FooGrpcQueryServiceBase {
  _$FooGrpcQueryService(this.app);

  final FooApp app;
  @override
  Stream<FooIdEvent> getFooIds(ServiceCall call, Empty request) {
    // TODO: implement getFooIds
    throw UnimplementedError();
  }

  @override
  Future<FooState1Response> getFooState1(
    ServiceCall call,
    FooState1Request request,
  ) async {
    try {
      final result = await app.store.load(FooId(request.id));
      return FooState1Response()
        ..state = FooState1Response_FooState1(
          title: result.title,
          author: result.author,
        );
    } on AggregateNotFoundException catch (e) {
      return FooState1Response()
        ..error = FooState1Response_Error(
          statusCode: 404,
          reasonPhrase: e.message,
        );
    }
  }

  @override
  Stream<FooEvent> subscribeToFooEvents(
      ServiceCall call, SubscribeToFooEventsRequest request) {
    // TODO: implement subscribeToFooEvents
    throw UnimplementedError();
  }
}

// **************************************************************************
// ApplicationGenerator
// **************************************************************************

typedef FooResult
    = AggregateCommandResult<JsonObject, FooStateModel1, FooId, FooState1, Foo>;

typedef FooOk = AggregateCommandOkResult<JsonObject, FooStateModel1, FooId,
    FooState1, Foo>;

typedef FooError = AggregateCommandErrorResult<JsonObject, FooStateModel1,
    FooId, FooState1, Foo>;

abstract class _$FooApp extends ApplicationServiceBase<JsonMap, JsonObject,
    FooStateModel1, FooId, FooState1, Foo> {
  _$FooApp(FooStore store) : super(store) {
    onNew<CreateFoo>(
      (cmd) => FooId(cmd.fooId),
      (cmd, foo) => foo.createFoo(title: cmd.title, author: cmd.author),
    );

    onExisting<UpdateFoo>(
      (cmd) => FooId(cmd.fooId),
      (cmd, foo) => foo.updateFoo(cmd.title, cmd.author),
    );

    onAny<ImportFoo>(
      (cmd) => FooId(cmd.fooId),
      (cmd, foo) => foo.importFoo(cmd.title, cmd.author),
    );
  }
  FutureOr<FooResult> createFoo(
      {required String fooId, required String title, required String author}) {
    return handle(CreateFoo(fooId: fooId, title: title, author: author));
  }

  FutureOr<FooResult> updateFoo(String fooId, String title, String? author) {
    return handle(UpdateFoo(fooId, title, author));
  }

  FutureOr<FooResult> importFoo(String fooId, String title,
      [String? author = 'user']) {
    return handle(ImportFoo(fooId, title, author));
  }
}

// **************************************************************************
// AggregateGenerator
// **************************************************************************

typedef FooStore = AggregateStore<JsonMap, JsonObject, FooStateModel1, FooId,
    FooState1, Foo>;

typedef FooState1Result
    = AggregateStateResult<JsonObject, FooStateModel1, FooId, FooState1>;

typedef FooState1Ok
    = AggregateStateOk<JsonObject, FooStateModel1, FooId, FooState1>;

typedef FooState1Error
    = AggregateStateError<JsonObject, FooStateModel1, FooId, FooState1>;

typedef FooState1NoOp
    = AggregateStateNoOp<JsonObject, FooStateModel1, FooId, FooState1>;

abstract class _$Foo
    extends Aggregate<JsonObject, FooStateModel1, FooId, FooState1> {
  _$Foo(FooId id, FooState1? state) : super(id, state ?? FooState1()) {
    AggregateTypes.define<JsonObject, FooStateModel1, FooId, FooState1, Foo>(
      (id, [state]) => Foo(id, state),
    );
  }
  // ignore: unused_element
  static Foo from(String id) => Foo(FooId(id));

  String? get title => current.title;
  String? get author => current.author;

  FooState1Result createFoo({required String title, required String author}) {
    ensureDoesntExists();
    return apply(FooCreated(fooId: id.value, title: title, author: author));
  }

  FooState1Result updateFoo(String title, String? author) {
    ensureExists();
    return apply(FooUpdated(id.value, title, author));
  }

  FooState1Result importFoo(String title, [String? author = 'user']) {
    return apply(FooImported(id.value, title, author));
  }
}

// **************************************************************************
// AggregateCommandGenerator
// **************************************************************************

abstract class _$CreateFoo extends JsonObject {
  _$CreateFoo(List<Object?> props) : super(props);

  // ignore: unused_element
  static CreateFoo fromJson(JsonMap json) => _$CreateFooFromJson(json);

  @override
  JsonMap toJson() => _$CreateFooToJson(this as CreateFoo);
}

abstract class _$UpdateFoo extends JsonObject {
  _$UpdateFoo(List<Object?> props) : super(props);

  // ignore: unused_element
  static UpdateFoo fromJson(JsonMap json) => _$UpdateFooFromJson(json);

  @override
  JsonMap toJson() => _$UpdateFooToJson(this as UpdateFoo);
}

abstract class _$ImportFoo extends JsonObject {
  _$ImportFoo(List<Object?> props) : super(props);

  // ignore: unused_element
  static ImportFoo fromJson(JsonMap json) => _$ImportFooFromJson(json);

  @override
  JsonMap toJson() => _$ImportFooToJson(this as ImportFoo);
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _$FooCreated extends JsonObject {
  _$FooCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, FooCreated>(
      _$FooCreated.fromJson,
    );
  }

  static FooCreated fromJson(JsonMap json) => _$FooCreatedFromJson(json);

  @override
  JsonMap toJson() => _$FooCreatedToJson(this as FooCreated);
}

abstract class _$FooUpdated extends JsonObject {
  _$FooUpdated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, FooUpdated>(
      _$FooUpdated.fromJson,
    );
  }

  static FooUpdated fromJson(JsonMap json) => _$FooUpdatedFromJson(json);

  @override
  JsonMap toJson() => _$FooUpdatedToJson(this as FooUpdated);
}

abstract class _$FooImported extends JsonObject {
  _$FooImported(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, FooImported>(
      _$FooImported.fromJson,
    );
  }

  static FooImported fromJson(JsonMap json) => _$FooImportedFromJson(json);

  @override
  JsonMap toJson() => _$FooImportedToJson(this as FooImported);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _$FooStateModel1 extends JsonObject {
  _$FooStateModel1(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, FooStateModel1>(
      _$FooStateModel1.fromJson,
    );
  }

  static FooStateModel1 fromJson([JsonMap? json]) =>
      _$FooStateModel1FromJson(json ?? {});

  @override
  JsonMap toJson() => _$FooStateModel1ToJson(this as FooStateModel1);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _$FooState1 extends AggregateState<FooStateModel1> {
  _$FooState1(FooStateModel1? value, int? version)
      : super(value ?? FooStateModel1(), version) {
    AggregateStateTypes.define<FooStateModel1, FooState1>(
      ([value, version]) => FooState1(value, version),
    );
  }

  String? get title => value.title;
  String? get author => value.author;

  FooState1 patch(JsonObject event, FooStateModel1 value) {
    return FooState1(AggregateValueTypes.create<JsonMap, FooStateModel1>(
      JsonUtils.patch(
        value,
        event,
      ),
    ));
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FooStateModel1 _$FooStateModel1FromJson(Map<String, dynamic> json) =>
    FooStateModel1(
      title: json['title'] as String?,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$FooStateModel1ToJson(FooStateModel1 instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };

CreateFoo _$CreateFooFromJson(Map<String, dynamic> json) => CreateFoo(
      fooId: json['fooId'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$CreateFooToJson(CreateFoo instance) => <String, dynamic>{
      'fooId': instance.fooId,
      'title': instance.title,
      'author': instance.author,
    };

UpdateFoo _$UpdateFooFromJson(Map<String, dynamic> json) => UpdateFoo(
      json['fooId'] as String,
      json['title'] as String,
      json['author'] as String?,
    );

Map<String, dynamic> _$UpdateFooToJson(UpdateFoo instance) => <String, dynamic>{
      'fooId': instance.fooId,
      'title': instance.title,
      'author': instance.author,
    };

ImportFoo _$ImportFooFromJson(Map<String, dynamic> json) => ImportFoo(
      json['fooId'] as String,
      json['title'] as String,
      json['author'] as String? ?? 'user',
    );

Map<String, dynamic> _$ImportFooToJson(ImportFoo instance) => <String, dynamic>{
      'fooId': instance.fooId,
      'title': instance.title,
      'author': instance.author,
    };

FooCreated _$FooCreatedFromJson(Map<String, dynamic> json) => FooCreated(
      fooId: json['fooId'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$FooCreatedToJson(FooCreated instance) =>
    <String, dynamic>{
      'fooId': instance.fooId,
      'title': instance.title,
      'author': instance.author,
    };

FooUpdated _$FooUpdatedFromJson(Map<String, dynamic> json) => FooUpdated(
      json['fooId'] as String,
      json['title'] as String,
      json['author'] as String?,
    );

Map<String, dynamic> _$FooUpdatedToJson(FooUpdated instance) =>
    <String, dynamic>{
      'fooId': instance.fooId,
      'title': instance.title,
      'author': instance.author,
    };

FooImported _$FooImportedFromJson(Map<String, dynamic> json) => FooImported(
      json['fooId'] as String,
      json['title'] as String,
      json['author'] as String?,
    );

Map<String, dynamic> _$FooImportedToJson(FooImported instance) =>
    <String, dynamic>{
      'fooId': instance.fooId,
      'title': instance.title,
      'author': instance.author,
    };
