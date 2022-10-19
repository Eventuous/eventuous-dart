import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/element_model.dart';

import 'item_model.dart';
import 'parameter_model.dart';

class AnnotationModel extends JsonObject {
  AnnotationModel(
    this.type,
    this.annotationOf, {
    this.location,
    this.parameters = const [],
    this.documentationComment,
    this.usesJsonSerializable = false,
  }) : super([
          type,
          annotationOf,
          location,
          parameters,
          documentationComment,
          usesJsonSerializable,
        ]);
  final String type;
  final String? location;
  final String annotationOf;
  final bool usesJsonSerializable;
  final String? documentationComment;
  final List<ParameterModel> parameters;

  bool isAnnotationExact<T>() => type == '${typeOf<T>()}';
  bool hasParameter(String name, String value) =>
      parameters.any((e) => e.name == name && e.value == value);

  /// Get property names
  @override
  Iterable<String> get names {
    return [...toJson().keys, ...parameters.map((p) => p.name)];
  }

  String getTName(String type) {
    final parameter = this[type];
    if (parameter is ParameterModel) {
      return parameter.value;
    }
    throw ArgumentError.value(parameter, type, 'type not found');
  }

  /// Get value with [property] name from [toJson]
  @override
  Object? operator [](Object? name) =>
      toJson()[name] ?? parameters.firstWhereOrNull((p) => p.name == name);

  T typedAt<T>(Object name, [T? defaultValue]) =>
      (this[name] ?? defaultValue) as T;

  String valueAt(Object name, [String defaultValue = '']) =>
      typedAt<ParameterModel?>(name)?.value ?? defaultValue;

  ParameterModel parameterAt(String name, [String defaultValue = '']) {
    final param = typedAt<ParameterModel?>(name);
    return param ?? ParameterModel(name, defaultValue);
  }

  ElementModel elementAt(Object name) {
    return ElementModel(
      name.toString(),
      (jsonDecode(
        typedAt<ParameterModel>(
          name,
          ParameterModel(name.toString(), '[]'),
        ).value,
      ) as List)
          .map((e) => ItemModel.fromJson(Map.from(e as Map)))
          .toList(),
    );
  }

  /// Factory constructor for creating a new `AnnotationModel` instance
  factory AnnotationModel.fromJson(Map<String, dynamic> json) =>
      AnnotationModel(json['type'] as String, json['annotationOf'] as String,
          location: json['location'] as String?,
          usesJsonSerializable: json['usesJsonSerializable'] as bool,
          documentationComment: json['documentationComment'] as String?,
          parameters: List.from(json.listAt('parameters') ?? [])
              .map((p) => ParameterModel.fromJson(p as JsonMap))
              .toList());

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'type': type,
        'annotationOf': annotationOf,
        if (location != null) 'location': location,
        'usesJsonSerializable': usesJsonSerializable,
        'parameters': parameters.map((e) => e.toJson()).toList(),
        if (documentationComment != null)
          'documentationComment': documentationComment,
      };
}
