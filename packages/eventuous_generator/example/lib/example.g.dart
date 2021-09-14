// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleStateModel1 _$ExampleStateModel1FromJson(Map<String, dynamic> json) =>
    ExampleStateModel1(
      title: json['title'] as String?,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$ExampleStateModel1ToJson(ExampleStateModel1 instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };

ExampleCreated _$ExampleCreatedFromJson(Map<String, dynamic> json) =>
    ExampleCreated(
      json['title'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$ExampleCreatedToJson(ExampleCreated instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };
