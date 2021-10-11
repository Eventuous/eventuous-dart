import 'package:analyzer/dart/constant/value.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import 'builders/models/annotation_model.dart';
import 'builders/models/parameter_model.dart';
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

final rx = RegExp(r'\((\d)\)');

ExpectedState parameterExpectedStateAt(
  String field,
  ConstantReader annotation, {
  AnnotationModel? model,
}) {
  return toExpectedState(
    parameterObjectAt(field, annotation, model: model, toString: (o) {
      return enumName(ExpectedState.values[int.parse(
          rx.firstMatch(o.toString())?.group(1) ??
              ExpectedState.any.index.toString())]);
    }, defaultValue: enumName(ExpectedState.any))
        .toString(),
  );
}

Object parameterObjectAt(
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

String parameterTypeAt(
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
