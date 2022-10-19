import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import 'builders/models/annotation_model.dart';
import 'builders/models/inference_model.dart';
import 'builders/models/parameter_model.dart';
import 'extensions.dart';

final docPrefix = RegExp(r'/+\s+');
String? toDocumentation(Element element) {
  final doc = element is PropertyAccessorElement
      ? (element.documentationComment ?? element.variable.documentationComment)
      : element.documentationComment;
  return doc != null
      ? LineSplitter.split(doc)
          .map((e) => e.replaceFirst(docPrefix, ''))
          .join('\n')
      : null;
}

String toInferenceJsonAsString({
  bool inferTypes = true,
  bool lazyService = true,
  List<String> annotations = const [],
  String initializeName = r'_$initEventuous',
}) {
  final pattern = RegExp(r'\[(.*)\]');
  final items = annotations
      .map((a) => pattern.firstMatch(a))
      .where((e) => e != null)
      .map((e) => e!.group(1))
      .join(',');

  return '{"config":{"${Eventuous.inferTypesField}":$inferTypes,'
      '"${Eventuous.lazyServiceField}":$lazyService,'
      '"${Eventuous.initializerNameField}":"$initializeName"},'
      '"annotations":[$items]}';
}

Future<InferenceModel> readInference(
  Map<String, Object?> config,
  BuildStep buildStep, [
  bool ensure = false,
]) async {
  final id = toInferenceAssetId(buildStep);
  if (await buildStep.canRead(id)) {
    final json = await buildStep.readAsString(toInferenceAssetId(buildStep));
    return InferenceModel.fromJson(JsonMap.from(jsonDecode(json) as Map));
  }
  throw InvalidGenerationSourceError(
    "Asset $id not found.\n\nVerify that target "
    "'eventuous_generator|inference_builder' "
    "is enabled in build.xml",
  );
}

AssetId toInferenceAssetId(BuildStep buildStep) {
  return AssetId(
    buildStep.inputId.package,
    p.join('lib', 'inference.json'),
  );
}

Eventuous toEventuousOptions(
  Map<String, Object?> config, [
  DartObject? annotation,
]) {
  config.putIfAbsent(
    Eventuous.inferTypesField,
    () => annotation?.getField('inferTypes')?.toBoolValue(),
  );
  config.putIfAbsent(
    Eventuous.lazyServiceField,
    () => annotation?.getField('lazyService')?.toBoolValue(),
  );
  config.putIfAbsent(
    Eventuous.initializerNameField,
    () => annotation?.getField('initializerName')?.toStringValue(),
  );
  return Eventuous.fromJson(config);
}

final _pattern = RegExp(r'\((\d)\)');

ExpectedState parameterExpectedStateAt(
  String field,
  ConstantReader annotation, {
  AnnotationModel? model,
}) {
  return toExpectedState(
    fieldObjectAt(field, annotation, model: model, toString: (o) {
      return enumName(ExpectedState.values[int.parse(
          _pattern.firstMatch(o.toString())?.group(1) ??
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
