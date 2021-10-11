import 'package:collection/collection.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/config_model.dart';

import 'annotation_model.dart';

class InferenceModel extends JsonObject {
  InferenceModel(
    this.config, {
    this.annotations = const [],
  }) : super([config, annotations]);

  final ConfigModel config;
  final List<AnnotationModel> annotations;

  List<AnnotationModel> get apps => where<ApplicationType>();
  List<AnnotationModel> get aggregates => where<AggregateType>();
  List<AnnotationModel> get events => where<AggregateEventType>();
  List<AnnotationModel> get values => where<AggregateValueType>();
  List<AnnotationModel> get states => where<AggregateStateType>();
  List<AnnotationModel> get commands => where<AggregateCommandType>();

  List<AnnotationModel> where<T>([String? aggregate]) => annotations
      .map((a) => a)
      .where((a) => a.type == '$T')
      .where((a) =>
          aggregate == null ||
          a.annotationOf == aggregate ||
          a.hasParameter('aggregate', aggregate))
      .toList();

  bool hasAnnotationOfExact<T>([String? aggregate]) {
    return annotations.any((a) =>
        a.type == '$T' &&
        (aggregate == null ||
            a.annotationOf == aggregate ||
            a.hasParameter('aggregate', aggregate)));
  }

  AnnotationModel? firstAnnotationOf<T>([String? aggregate]) =>
      annotations.firstWhereOrNull((a) =>
          a.type == '$T' &&
          (aggregate == null ||
              a.annotationOf == aggregate ||
              a.hasParameter('aggregate', aggregate)));

  List<AnnotationModel> annotationsOf<T>([String? aggregate]) => annotations
      .where((a) =>
          a.type == '$T' &&
          (aggregate == null ||
              a.annotationOf == aggregate ||
              a.hasParameter('aggregate', aggregate)))
      .toList();

  /// Factory constructor for creating a new `InferenceModel` instance
  factory InferenceModel.fromJson(Map<String, dynamic> json) => InferenceModel(
        ConfigModel.fromJson(json['config'] ?? <String, dynamic>{}),
        annotations: List.from(json['annotations'] ?? <JsonMap>[])
            .map((a) => AnnotationModel.fromJson(a))
            .toList(),
      );

  factory InferenceModel.fromConfig(Map<String, dynamic> json) =>
      InferenceModel(ConfigModel.fromJson(json));

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'config': config.toJson(),
        'annotations': annotations.map((a) => a.toJson()).toList(),
      };
}
