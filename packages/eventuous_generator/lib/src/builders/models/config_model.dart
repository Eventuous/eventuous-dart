import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/helpers.dart';

class ConfigModel extends JsonObject {
  ConfigModel(
    this.inferTypes,
    this.lazyService,
    this.initializerName,
  ) : super([inferTypes, initializerName]);

  final bool inferTypes;
  final bool lazyService;
  final String initializerName;

  /// Factory constructor for creating a new `ConfigModel` instance
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    final options = toEventuousOptions(json);
    return ConfigModel(
      options.inferTypes,
      options.lazyService,
      options.initializerName,
    );
  }

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        Eventuous.inferTypesField: inferTypes,
        Eventuous.lazyServiceField: lazyService,
        Eventuous.initializerNameField: initializerName,
      };
}
