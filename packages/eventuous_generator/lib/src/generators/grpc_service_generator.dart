// ignore_for_file: unused_import

import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/templates/grpc_service_template.dart';
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';
import '../extensions.dart';

import 'code_generator.dart';

class GrpcServiceGenerator extends CodeGenerator<GrpcServiceType> {
  GrpcServiceGenerator(Map<String, Object?> config) : super(config);

  @override
  String generateForClass(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
  ) {
    final tpl = GrpcServiceTemplate.from(
      config,
      inference,
      element.name,
      annotation.toFieldTypeName('aggregate'),
    );
    log.config(
      LineSplitter.split(tpl.toImportString())
          .map((e) => e.replaceFirst(r'//', ''))
          .join('\n'),
    );
    return tpl.toString();
  }
}
