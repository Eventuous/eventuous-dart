import 'package:analyzer/dart/constant/value.dart';
import 'package:eventuous/eventuous.dart';

Eventuous parseConfig(Map<String, Object?> config, [DartObject? annotation]) {
  final inferTypes = annotation?.getField('inferTypes')?.toBoolValue() ??
      config['infer_types'] as bool? ??
      true;
  final initializerName =
      annotation?.getField('initializerName')?.toStringValue() ??
          config['initializer_name'] as String? ??
          r'_$initEventuous';

  return Eventuous(
    inferTypes: inferTypes,
    initializerName: initializerName,
  );
}
