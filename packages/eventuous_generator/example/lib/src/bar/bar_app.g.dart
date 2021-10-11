// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_app.dart';

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
