// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_commands.dart';

// **************************************************************************
// AggregateCommandGenerator
// **************************************************************************

abstract class _$CreateBar extends JsonObject {
  _$CreateBar(List<Object?> props) : super(props);

  // ignore: unused_element
  static CreateBar fromJson(JsonMap json) => _$CreateBarFromJson(json);

  @override
  JsonMap toJson() => _$CreateBarToJson(this as CreateBar);
}

abstract class _$UpdateBar extends JsonObject {
  _$UpdateBar(List<Object?> props) : super(props);

  // ignore: unused_element
  static UpdateBar fromJson(JsonMap json) => _$UpdateBarFromJson(json);

  @override
  JsonMap toJson() => _$UpdateBarToJson(this as UpdateBar);
}

abstract class _$ImportBar extends JsonObject {
  _$ImportBar(List<Object?> props) : super(props);

  // ignore: unused_element
  static ImportBar fromJson(JsonMap json) => _$ImportBarFromJson(json);

  @override
  JsonMap toJson() => _$ImportBarToJson(this as ImportBar);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBar _$CreateBarFromJson(Map<String, dynamic> json) => CreateBar(
      barId: json['barId'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$CreateBarToJson(CreateBar instance) => <String, dynamic>{
      'barId': instance.barId,
      'title': instance.title,
      'author': instance.author,
    };

UpdateBar _$UpdateBarFromJson(Map<String, dynamic> json) => UpdateBar(
      json['barId'] as String,
      json['title'] as String,
      json['author'] as String?,
    );

Map<String, dynamic> _$UpdateBarToJson(UpdateBar instance) => <String, dynamic>{
      'barId': instance.barId,
      'title': instance.title,
      'author': instance.author,
    };

ImportBar _$ImportBarFromJson(Map<String, dynamic> json) => ImportBar(
      json['barId'] as String,
      json['title'] as String,
      json['author'] as String? ?? 'user',
    );

Map<String, dynamic> _$ImportBarToJson(ImportBar instance) => <String, dynamic>{
      'barId': instance.barId,
      'title': instance.title,
      'author': instance.author,
    };
