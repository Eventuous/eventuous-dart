import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:source_gen/source_gen.dart';

import '../templates/aggregate_template.dart';
import '../builders/models/inference_model.dart';

import 'code_generator.dart';

class AggregateGenerator extends CodeGenerator<AggregateType> {
  AggregateGenerator(Map<String, Object?> config) : super(config);

  @override
  String generateForType(
      InferenceModel inference, Element element, ConstantReader annotation) {
    return AggregateTemplate.from(inference, element, annotation).toString();
  }
}
