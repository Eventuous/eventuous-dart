// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar.dart';

// **************************************************************************
// AggregateGenerator
// **************************************************************************

abstract class _$Bar extends Aggregate<JsonObject, BarValue, BarId1, BarState> {
  _$Bar(BarId1 id, BarState? state) : super(id, state ?? BarState()) {
    AggregateTypes.define<JsonObject, BarValue, BarId1, BarState, Bar>(
      (id, [state]) => Bar(id, state),
    );
  }
  // ignore: unused_element
  static Bar from(String id) => Bar(BarId1(id));
}
