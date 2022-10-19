import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../templates/application_template.dart';
import '../builders/models/inference_model.dart';

import 'code_generator.dart';

class ApplicationGenerator extends CodeGenerator<ApplicationType> {
  ApplicationGenerator(Map<String, Object?> config) : super(config);

  @override
  String generateForClass(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
  ) {
    return ApplicationTemplate.from(inference, element, annotation).toString();
  }
}
