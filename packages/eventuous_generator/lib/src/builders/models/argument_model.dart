import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';

import '../../extensions.dart';

class ArgumentModel extends JsonObject {
  ArgumentModel(
    this.type,
    this.name,
    this.isNamed,
    this.isRequired,
    this.isPositional,
    this.defaultValueCode,
  ) : super([type, name, isNamed]);
  final String type;
  final String name;
  final bool isNamed;
  final bool isRequired;
  final bool isPositional;
  final String? defaultValueCode;

  bool get isOptional => !isRequired;
  bool get hasDefaultValueCode => defaultValueCode != null;

  /// Create a new `ArgumentModel` instance from [ParameterElement]
  factory ArgumentModel.from(ParameterElement element) {
    // TODO: Validate constructor
    return ArgumentModel(
      element.type.toTypeName(),
      element.displayName.toMemberCase(),
      element.isNamed || element.isRequiredNamed || element.isOptionalNamed,
      element.isRequiredPositional || element.isRequiredNamed,
      element.isPositional || element.isRequiredPositional,
      element.defaultValueCode,
    );
  }

  /// Factory constructor for creating a new `ArgumentModel` instance
  factory ArgumentModel.fromJson(Map<String, dynamic> json) => ArgumentModel(
        json['type'] as String,
        json['name'] as String,
        json['isNamed'] as bool,
        json['isRequired'] as bool,
        json['isPositional'] as bool,
        json['defaultValueCode'] as String?,
      );

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'type': type,
        'name': name,
        'isNamed': isNamed,
        'isRequired': isRequired,
        'isPositional': isPositional,
        if (defaultValueCode != null) 'defaultValueCode': defaultValueCode,
      };
}
