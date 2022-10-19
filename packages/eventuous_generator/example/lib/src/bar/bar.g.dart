// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar.dart';

// **************************************************************************
// AggregateGenerator
// **************************************************************************

typedef BarStore
    = AggregateStore<JsonMap, JsonObject, BarValue, BarId1, BarState, Bar>;

typedef BarStateResult
    = AggregateStateResult<JsonObject, BarValue, BarId1, BarState>;

typedef BarStateOk = AggregateStateOk<JsonObject, BarValue, BarId1, BarState>;

typedef BarStateError
    = AggregateStateError<JsonObject, BarValue, BarId1, BarState>;

typedef BarStateNoOp
    = AggregateStateNoOp<JsonObject, BarValue, BarId1, BarState>;

abstract class _$Bar extends Aggregate<JsonObject, BarValue, BarId1, BarState> {
  _$Bar(BarId1 id, BarState? state) : super(id, state ?? BarState()) {
    AggregateTypes.define<JsonObject, BarValue, BarId1, BarState, Bar>(
      (id, [state]) => Bar(id, state),
    );
  }
  // ignore: unused_element
  static Bar from(String id) => Bar(BarId1(id));

  String? get title => current.title;
  BarAuthor? get author => current.author;

  BarStateResult createBar({required String title, required String author}) {
    ensureDoesntExists();
    return apply(BarCreated(barId: id.value, title: title, author: author));
  }

  BarStateResult updateBar(String title, String? author) {
    ensureExists();
    return apply(BarUpdated(id.value, title, author));
  }

  BarStateResult importBar(String title, [String? author = 'user']) {
    return apply(BarImported(id.value, title, author));
  }
}
