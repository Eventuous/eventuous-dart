import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../builders/models/inference_model.dart';
import '../templates/aggregate_command_template.dart';

import 'code_generator.dart';

class AggregateCommandGenerator extends CodeGenerator<AggregateCommandType> {
  AggregateCommandGenerator(Map<String, Object?> config) : super(config);

  @override
  String generateForType(
      InferenceModel inference, Element element, ConstantReader annotation) {
    return AggregateCommandTemplate.from(inference, element, annotation)
        .toString();
  }
}
