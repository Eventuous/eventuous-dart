// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_app.dart';

// **************************************************************************
// GrpcServiceGenerator
// **************************************************************************

// The following imports must be added /eventuous_generator/example/lib/src/bar/bar_app.dart:
//
// import 'TODO: rootPath/generated/bar_app.pbgrpc.dart';
// import 'TODO: rootPath/generated/google/protobuf/empty.pb.dart';
//
class _$BarGrpcCommandService extends BarGrpcCommandServiceBase {
  _$BarGrpcCommandService(this.app);

  final BarApp app;

  @override
  Future<CreateBarResponse> executeCreateBar(
    ServiceCall call,
    CreateBarRequest request,
  ) async {
    final result = await app.createBar(
      barId: request.barId,
      title: request.title,
      author: request.author,
    );
    return result is BarError
        ? (CreateBarResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => CreateBarResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (CreateBarResponse()..success = CreateBarResponse_Success());
  }

  @override
  Future<UpdateBarResponse> executeUpdateBar(
    ServiceCall call,
    UpdateBarRequest request,
  ) async {
    final result = await app.updateBar(
      request.barId,
      request.title,
      request.author,
    );
    return result is BarError
        ? (UpdateBarResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => UpdateBarResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (UpdateBarResponse()..success = UpdateBarResponse_Success());
  }

  @override
  Future<ImportBarResponse> executeImportBar(
    ServiceCall call,
    ImportBarRequest request,
  ) async {
    final result = await app.importBar(
      request.barId,
      request.title,
      request.author,
    );
    return result is BarError
        ? (ImportBarResponse()
          ..error = _toCommandError(
            call,
            result,
            (code, phrase) => ImportBarResponse_Error(
              statusCode: code,
              reasonPhrase: phrase,
            ),
          ))
        : (ImportBarResponse()..success = ImportBarResponse_Success());
  }

  T _toCommandError<T>(
    ServiceCall call,
    BarError error,
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
        return toError(404, 'Bar ${error.aggregate?.id} not found');
      case AggregateExistsException:
        return toError(409, 'Bar ${error.aggregate?.id} exists');
      case ConcurrentModificationException:
        return toError(409, 'Concurrent modification');
    }
    return toError(500, 'Internal error: ${error.cause.toString()}');
  }
}

class _$BarGrpcQueryService extends BarGrpcQueryServiceBase {
  _$BarGrpcQueryService(this.app);

  final BarApp app;

  @override
  Stream<BarEvent> subscribeToBarEvents(
      ServiceCall call, SubscribeToBarEventsRequest request) {
    // TODO: implement subscribeToBarEvents
    throw UnimplementedError();
  }
}

// **************************************************************************
// ApplicationGenerator
// **************************************************************************

typedef BarResult
    = AggregateCommandResult<JsonObject, BarValue, BarId1, BarState, Bar>;

typedef BarOk
    = AggregateCommandOkResult<JsonObject, BarValue, BarId1, BarState, Bar>;

typedef BarError
    = AggregateCommandErrorResult<JsonObject, BarValue, BarId1, BarState, Bar>;

abstract class _$BarApp extends ApplicationServiceBase<JsonMap, JsonObject,
    BarValue, BarId1, BarState, Bar> {
  _$BarApp(BarStore store) : super(store) {
    onNew<CreateBar>(
      (cmd) => BarId1(cmd.barId),
      (cmd, bar) => bar.createBar(title: cmd.title, author: cmd.author),
    );

    onExisting<UpdateBar>(
      (cmd) => BarId1(cmd.barId),
      (cmd, bar) => bar.updateBar(cmd.title, cmd.author),
    );

    onAny<ImportBar>(
      (cmd) => BarId1(cmd.barId),
      (cmd, bar) => bar.importBar(cmd.title, cmd.author),
    );
  }
  FutureOr<BarResult> createBar(
      {required String barId, required String title, required String author}) {
    return handle(CreateBar(barId: barId, title: title, author: author));
  }

  FutureOr<BarResult> updateBar(String barId, String title, String? author) {
    return handle(UpdateBar(barId, title, author));
  }

  FutureOr<BarResult> importBar(String barId, String title,
      [String? author = 'user']) {
    return handle(ImportBar(barId, title, author));
  }
}
