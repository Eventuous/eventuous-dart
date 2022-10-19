import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';

class AggregateIdTemplate {
  AggregateIdTemplate({
    required this.name,
    required this.query,
    required this.aggregate,
  });

  factory AggregateIdTemplate.from(
    InferenceModel inference,
    Element element,
    ConstantReader annotation,
  ) {
    final name = element.displayName;
    final aggregate = annotation.toFieldTypeName('aggregate');
    final id = inference.firstAnnotationOf<AggregateIdType>(aggregate);

    return AggregateIdTemplate(
      name: name,
      aggregate: aggregate,
      query: id?.valueAt('query') == 'true',
    );
  }

  final bool query;
  final String name;
  final String aggregate;
}
