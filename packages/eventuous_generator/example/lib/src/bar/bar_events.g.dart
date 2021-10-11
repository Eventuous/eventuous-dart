// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_events.dart';

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _$BarCreated extends JsonObject {
  _$BarCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, BarCreated>(
      _$BarCreated.fromJson,
    );
  }

  static BarCreated fromJson(JsonMap json) => _$BarCreatedFromJson(json);

  @override
  JsonMap toJson() => _$BarCreatedToJson(this as BarCreated);
}

abstract class _$BarUpdated extends JsonObject {
  _$BarUpdated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, BarUpdated>(
      _$BarUpdated.fromJson,
    );
  }

  static BarUpdated fromJson(JsonMap json) => _$BarUpdatedFromJson(json);

  @override
  JsonMap toJson() => _$BarUpdatedToJson(this as BarUpdated);
}

abstract class _$BarImported extends JsonObject {
  _$BarImported(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, BarImported>(
      _$BarImported.fromJson,
    );
  }

  static BarImported fromJson(JsonMap json) => _$BarImportedFromJson(json);

  @override
  JsonMap toJson() => _$BarImportedToJson(this as BarImported);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarCreated _$BarCreatedFromJson(Map<String, dynamic> json) => BarCreated(
      barId: json['barId'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$BarCreatedToJson(BarCreated instance) =>
    <String, dynamic>{
      'barId': instance.barId,
      'title': instance.title,
      'author': instance.author,
    };

BarUpdated _$BarUpdatedFromJson(Map<String, dynamic> json) => BarUpdated(
      json['barId'] as String,
      json['title'] as String,
      json['author'] as String?,
    );

Map<String, dynamic> _$BarUpdatedToJson(BarUpdated instance) =>
    <String, dynamic>{
      'barId': instance.barId,
      'title': instance.title,
      'author': instance.author,
    };

BarImported _$BarImportedFromJson(Map<String, dynamic> json) => BarImported(
      json['barId'] as String,
      json['title'] as String,
      json['author'] as String?,
    );

Map<String, dynamic> _$BarImportedToJson(BarImported instance) =>
    <String, dynamic>{
      'barId': instance.barId,
      'title': instance.title,
      'author': instance.author,
    };
