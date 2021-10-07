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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarCreated _$BarCreatedFromJson(Map<String, dynamic> json) => BarCreated(
      json['title'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$BarCreatedToJson(BarCreated instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };
