import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aggregate_state_snapshot_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AggregateStateSnapshotModel<TValue extends Object> extends JsonObject {
  AggregateStateSnapshotModel(this.value, this.version)
      : super([value, version]);

  final int version;
  final TValue value;

  /// Factory constructor for creating a new `AggregateStateSnapshotModel` instance
  factory AggregateStateSnapshotModel.fromJson(Map<String, dynamic> json) =>
      _$AggregateStateSnapshotModelFromJson(
        json,
        (json) => AggregateEventTypes.create<JsonMap, TValue>(
          '$TValue',
          json as JsonMap,
        ),
      );

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$AggregateStateSnapshotModelToJson(
      this, (value) => value is JsonObject ? value.toJson() : value);
}
