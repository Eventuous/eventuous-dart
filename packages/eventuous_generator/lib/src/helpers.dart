import 'package:analyzer/dart/constant/value.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import 'builders/models/annotation_model.dart';
import 'builders/models/parameterized_type_model.dart';
import 'extensions.dart';

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

String parameterValueAt(
  String field,
  AnnotationModel? model,
  ConstantReader annotation, [
  String defaultValue = 'Object',
]) {
  return (model?[field] as ParameterizedTypeModel?)?.value ??
      annotation.toFieldTypeName(field, defaultValue);
}
