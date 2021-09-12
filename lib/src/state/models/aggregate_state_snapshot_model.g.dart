// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregate_state_snapshot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregateStateSnapshotModel<TValue>
    _$AggregateStateSnapshotModelFromJson<TValue extends Object>(
  Map json,
  TValue Function(Object? json) fromJsonTValue,
) =>
        AggregateStateSnapshotModel<TValue>(
          fromJsonTValue(json['value']),
          json['version'] as int,
        );

Map<String, dynamic> _$AggregateStateSnapshotModelToJson<TValue extends Object>(
  AggregateStateSnapshotModel<TValue> instance,
  Object? Function(TValue value) toJsonTValue,
) =>
    <String, dynamic>{
      'version': instance.version,
      'value': toJsonTValue(instance.value),
    };
