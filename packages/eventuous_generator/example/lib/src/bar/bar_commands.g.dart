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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBar _$CreateBarFromJson(Map<String, dynamic> json) => CreateBar(
      json['title'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$CreateBarToJson(CreateBar instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };
