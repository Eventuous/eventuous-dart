// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conflict_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConflictModel _$ConflictModelFromJson(Map<String, dynamic> json) =>
    ConflictModel(
      type: _$enumDecode(_$ConflictTypeEnumMap, json['type']),
      code: json['code'] as String?,
      base: json['base'] as Map<String, dynamic>?,
      mine: (json['mine'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      yours: (json['yours'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      error: json['error'] as String?,
      paths:
          (json['paths'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ConflictModelToJson(ConflictModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'error': instance.error,
      'type': _$ConflictTypeEnumMap[instance.type],
      'paths': instance.paths,
      'base': instance.base,
      'mine': instance.mine,
      'yours': instance.yours,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ConflictTypeEnumMap = {
  ConflictType.merge: 'merge',
  ConflictType.exists: 'exists',
  ConflictType.deleted: 'deleted',
};
