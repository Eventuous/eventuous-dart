import 'package:eventuous/eventuous.dart';

class ParameterModel extends JsonObject {
  ParameterModel(this.name, this.value) : super([name, value]);
  final String name;
  final String value;

  /// Factory constructor for creating a new `ParameterModel` instance
  factory ParameterModel.fromJson(Map<String, dynamic> json) =>
      ParameterModel(json['name'] as String, json['value'] as String);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {'name': name, 'value': value};
}
