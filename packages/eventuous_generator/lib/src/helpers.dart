import 'package:analyzer/dart/constant/value.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import 'builders/models/annotation_model.dart';
import 'builders/models/parameter_model.dart';
import 'extensions.dart';

Eventuous parseConfig(Map<String, Object?> config, [DartObject? annotation]) {
  final inferTypes = config['infer_types'] as bool? ??
      annotation?.getField('inferTypes')?.toBoolValue() ??
      true;

  final lazyService = config['lazy_service'] as bool? ??
      annotation?.getField('lazyService')?.toBoolValue() ??
      true;
  final initializerName = config['initializer_name'] as String? ??
      annotation?.getField('initializerName')?.toStringValue() ??
      r'_$initEventuous';

  return Eventuous(
    inferTypes: inferTypes,
    lazyService: lazyService,
    initializerName: initializerName,
  );
}

final rx = RegExp(r'\((\d)\)');

ExpectedState parameterExpectedStateAt(
  String field,
  ConstantReader annotation, {
  AnnotationModel? model,
}) {
  return toExpectedState(
    fieldObjectAt(field, annotation, model: model, toString: (o) {
      return enumName(ExpectedState.values[int.parse(
          rx.firstMatch(o.toString())?.group(1) ??
              ExpectedState.any.index.toString())]);
    }, defaultValue: enumName(ExpectedState.any))
        .toString(),
  );
}

Object fieldObjectAt(
  String field,
  ConstantReader annotation, {
  AnnotationModel? model,
  String Function(DartObject)? toString,
  String defaultValue = 'Object',
}) {
  final o = annotation.toFieldObject(field);
  return (model?[field] as ParameterModel?)?.value ??
      (o == null || toString == null ? defaultValue : toString(o));
}

String fieldTypeNameAt(
  String field,
  AnnotationModel? model,
  ConstantReader annotation, [
  String defaultValue = 'Object',
]) {
  return (model?[field] as ParameterModel?)?.value ??
      annotation.toFieldTypeName(field, defaultValue);
}

ExpectedState toExpectedState(String expected) {
  return ExpectedState.values.firstWhere((e) => enumName(e) == expected,
      orElse: () => ExpectedState.any);
}
