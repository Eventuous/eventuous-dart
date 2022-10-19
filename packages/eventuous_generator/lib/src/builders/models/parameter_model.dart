import 'package:eventuous/eventuous.dart';

class ParameterModel extends JsonObject {
  ParameterModel(
    this.name,
    this.value, [
    this.documentationComment,
  ]) : super([name, value, documentationComment]);

  final String name;
  final String value;
  final String? documentationComment;

  /// Factory constructor for creating a new `ParameterModel` instance
  factory ParameterModel.fromJson(Map<String, dynamic> json) => ParameterModel(
        json['name'] as String,
        json['value'] as String,
        json['documentationComment'] as String?,
      );

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'name': name,
        'value': value,
        if (documentationComment != null)
          'documentationComment': documentationComment,
      };
}
