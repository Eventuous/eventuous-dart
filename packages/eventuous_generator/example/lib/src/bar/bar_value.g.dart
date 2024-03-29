// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_value.dart';

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _$BarValue extends JsonObject {
  _$BarValue(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, BarValue>(
      _$BarValue.fromJson,
    );
  }

  static BarValue fromJson([JsonMap? json]) => _$BarValueFromJson(json ?? {});

  @override
  JsonMap toJson() => _$BarValueToJson(this as BarValue);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarValue _$BarValueFromJson(Map<String, dynamic> json) => BarValue(
      title: json['title'] as String?,
      author: json['author'] == null
          ? null
          : BarAuthor.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BarValueToJson(BarValue instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };

BarAuthor _$BarAuthorFromJson(Map<String, dynamic> json) => BarAuthor(
      json['fname'] as String,
      json['lname'] as String,
    );

Map<String, dynamic> _$BarAuthorToJson(BarAuthor instance) => <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
    };
