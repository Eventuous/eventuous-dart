import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:source_gen/source_gen.dart';

abstract class ApiSpecGenerator {
  ApiSpecGenerator(
    this.extension,
  );

  FutureOr<String> generateApi(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
  );

  final String extension;

  AssetId toAssetId(BuildStep buildStep) {
    return buildStep.allowedOutputs.firstWhere(
      (e) => e.extension == '.$extension',
      orElse: () => buildStep.inputId.changeExtension('.$extension'),
    );
  }

  List<String> toAllowedOutput([List<String> outputs = const []]) {
    return [
      outputs.firstWhere(
        (output) => output.endsWith(extension),
        orElse: () => 'protos/{{}}.$extension',
      )
    ];
  }
}
