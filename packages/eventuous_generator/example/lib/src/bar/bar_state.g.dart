// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_state.dart';

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _$BarState extends AggregateState<BarValue> {
  _$BarState(BarValue? value, int? version)
      : super(value ?? BarValue(), version) {
    AggregateStateTypes.define<BarValue, BarState>(
      ([value, version]) => BarState(value, version),
    );
    on<BarCreated>(patch);
  }

  BarState patch(JsonObject event, BarValue value) {
    return BarState(AggregateValueTypes.create<JsonMap, BarValue>(
      JsonUtils.patch(
        value,
        event,
      ),
    ));
  }
}
