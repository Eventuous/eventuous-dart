import 'package:eventuous/eventuous.dart';

class ConfigModel extends JsonObject {
  ConfigModel(
    this.inferTypes,
    this.initializeName,
  ) : super([inferTypes, initializeName]);

  final bool inferTypes;
  final String initializeName;

  /// Factory constructor for creating a new `ConfigModel` instance
  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        json['infer_types'] ?? true,
        json['initialize_name'] ?? r'_$initEventuous',
      );

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'infer_types': inferTypes,
        'initialize_name': initializeName,
      };
}
