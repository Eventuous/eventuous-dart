import 'package:collection/collection.dart';
import 'package:eventuous/eventuous.dart';

import 'parameterized_type_model.dart';

class AnnotationModel extends JsonObject {
  AnnotationModel(
    this.type,
    this.annotationOf, {
    this.parameters = const [],
    this.usesJsonSerializable = false,
  }) : super([type, annotationOf, parameters, usesJsonSerializable]);
  final String type;
  final String annotationOf;
  final bool usesJsonSerializable;
  final List<ParameterizedTypeModel> parameters;

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
    if (parameter is ParameterizedTypeModel) {
      return parameter.value;
    }
    throw ArgumentError.value(parameter, type, 'type not found');
  }

  /// Get value with [property] name from [toJson]
  @override
  Object? operator [](Object? name) =>
      toJson()[name] ?? parameters.firstWhereOrNull((p) => p.name == name);

  /// Factory constructor for creating a new `AnnotationModel` instance
  factory AnnotationModel.fromJson(Map<String, dynamic> json) =>
      AnnotationModel(json['type'] as String, json['annotationOf'] as String,
          usesJsonSerializable: json['usesJsonSerializable'] as bool,
          parameters: List.from(json['parameters'] ?? [])
              .map((p) => ParameterizedTypeModel.fromJson(p))
              .toList());

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'type': type,
        'annotationOf': annotationOf,
        'usesJsonSerializable': usesJsonSerializable,
        'parameters': parameters.map((e) => e.toJson()).toList(),
      };
}
