import 'package:eventuous/eventuous.dart';

class ParameterizedTypeModel extends JsonObject {
  ParameterizedTypeModel(this.name, this.value) : super([name, value]);
  final String name;
  final String value;

  /// Factory constructor for creating a new `ParameterizedTypeModel` instance
  factory ParameterizedTypeModel.fromJson(Map<String, dynamic> json) =>
      ParameterizedTypeModel(json['name'] as String, json['value'] as String);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {'name': name, 'value': value};
}
