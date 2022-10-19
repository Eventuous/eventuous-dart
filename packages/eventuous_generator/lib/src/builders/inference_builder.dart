import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/config_model.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:eventuous_generator/src/builders/models/parameter_model.dart';
import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';
import '../helpers.dart';
import 'models/annotation_model.dart';

const Map<Type, TypeChecker> checkers = {
  Eventuous: TypeChecker.fromRuntime(Eventuous),
  AggregateType: TypeChecker.fromRuntime(AggregateType),
  GrpcServiceType: TypeChecker.fromRuntime(GrpcServiceType),
  ApplicationType: TypeChecker.fromRuntime(ApplicationType),
  AggregateIdType: TypeChecker.fromRuntime(AggregateIdType),
  JsonSerializable: TypeChecker.fromRuntime(JsonSerializable),
  AggregateValueType: TypeChecker.fromRuntime(AggregateValueType),
  AggregateEventType: TypeChecker.fromRuntime(AggregateEventType),
  AggregateStateType: TypeChecker.fromRuntime(AggregateStateType),
  AggregateCommandType: TypeChecker.fromRuntime(AggregateCommandType),
};

class InferenceBuilder implements Builder {
  InferenceBuilder(
    Map<String, Object?> config,
  )   : _config = Map.from(config),
        _options = Eventuous.fromJson(config);

  final Eventuous _options;
  final Map<String, Object?> _config;

  @override
  Map<String, List<String>> get buildExtensions => {
        _options.inspectPath: ['inference.json']
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inferences = <AssetId, List<JsonMap>>{};
    final inspectPattern = _options.inspectPattern;
    await for (final input in buildStep.findAssets(Glob(inspectPattern))) {
      final library = await buildStep.resolver.libraryFor(input);
      inferences[input] = await infer(LibraryReader(library), buildStep);
    }

    final inference = _introspect(inferences);

    await buildStep.writeAsString(
      toInferenceAssetId(buildStep),
      jsonEncode(
        inference.toJson(),
      ),
    );
  }

  Future<List<JsonMap>> infer(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final inferences = <JsonMap>[];
    // Find configuration
    for (var e in library.annotatedWithExact(
      TypeChecker.fromRuntime(Eventuous),
    )) {
      final annotation = e.annotation.objectValue;
      inferences.add(
        AnnotationModel(
          '$Eventuous',
          e.element.displayName,
          location: e.element.source?.fullName,
          documentationComment: toDocumentation(e.element),
          parameters: [
            ParameterModel(
              'config',
              jsonEncode(
                toEventuousOptions(_config, annotation).toJson(),
              ),
            ),
          ],
        ).toJson(),
      );
    }
    for (var clz in library.classes) {
      for (var check in checkers.entries) {
        if (check.value.hasAnnotationOfExact(clz)) {
          final annotation = _firstAnnotationOf(check, clz);
          final usesJsonSerializable = clz.usesJsonSerializable;
          final reader = ConstantReader(annotation);
          switch (check.key) {
            case GrpcServiceType:
              inferences.add(
                AnnotationModel(
                  '$GrpcServiceType',
                  clz.name,
                  location: clz.source.fullName,
                  parameters: [
                    reader.toTypeModel('aggregate'),
                  ],
                  documentationComment: toDocumentation(clz),
                ).toJson(),
              );
              break;
            case ApplicationType:
              inferences.add(
                AnnotationModel(
                  '$ApplicationType',
                  clz.name,
                  location: clz.source.fullName,
                  usesJsonSerializable: usesJsonSerializable,
                  parameters: [reader.toTypeModel('aggregate')],
                  documentationComment: toDocumentation(clz),
                ).toJson(),
              );
              break;
            case AggregateType:
              inferences.add(
                AnnotationModel('$AggregateType', clz.name,
                    location: clz.source.fullName,
                    usesJsonSerializable: usesJsonSerializable,
                    documentationComment: toDocumentation(clz),
                    parameters: [
                      reader.toTypeModel('id', '${clz.name}Id'),
                      reader.toTypeModel('event'),
                      reader.toTypeModel('value', '${clz.name}Value'),
                      reader.toTypeModel('state', '${clz.name}State'),
                    ]).toJson(),
              );
              break;
            case AggregateIdType:
              inferences.add(
                AnnotationModel(
                  '$AggregateIdType',
                  clz.name,
                  location: clz.source.fullName,
                  usesJsonSerializable: usesJsonSerializable,
                  documentationComment: toDocumentation(clz),
                  parameters: [
                    reader.toTypeModel('aggregate'),
                    reader.toBoolModel('query', false),
                  ],
                ).toJson(),
              );
              break;
            case AggregateValueType:
              inferences.add(
                AnnotationModel('$AggregateValueType', clz.name,
                    location: clz.source.fullName,
                    usesJsonSerializable: usesJsonSerializable,
                    documentationComment: toDocumentation(clz),
                    parameters: [
                      clz.toGettersModel(),
                      reader.toTypeModel('aggregate'),
                      reader.toTypeModel(
                        'data',
                        usesJsonSerializable ? 'JsonMap' : 'Object',
                      ),
                    ]).toJson(),
              );
              break;
            case AggregateEventType:
              inferences.add(
                AnnotationModel('$AggregateEventType', clz.name,
                    location: clz.source.fullName,
                    usesJsonSerializable: usesJsonSerializable,
                    documentationComment: toDocumentation(clz),
                    parameters: [
                      reader.toTypeModel('aggregate'),
                      clz.toConstructorModel(),
                      reader.toTypeModel(
                        'data',
                        usesJsonSerializable ? 'JsonMap' : 'Object',
                      ),
                    ]).toJson(),
              );
              break;
            case AggregateStateType:
              inferences.add(
                AnnotationModel('$AggregateStateType', clz.displayName,
                    location: clz.source.fullName,
                    usesJsonSerializable: usesJsonSerializable,
                    documentationComment: toDocumentation(clz),
                    parameters: [
                      reader.toTypeModel('aggregate'),
                      reader.toTypeModel('value', '${clz.name}Value'),
                      reader.toBoolModel('query', false),
                    ]).toJson(),
              );
              break;
            case AggregateCommandType:
              inferences.add(
                AnnotationModel('$AggregateCommandType', clz.name,
                    location: clz.source.fullName,
                    usesJsonSerializable: usesJsonSerializable,
                    documentationComment: toDocumentation(clz),
                    parameters: [
                      reader.toTypeModel('event'),
                      reader.toTypeModel('aggregate'),
                      clz.toGettersModel(),
                      clz.toConstructorModel(),
                      reader.toExpectedStateModel('expected'),
                      reader.toTypeModel(
                        'data',
                        usesJsonSerializable ? 'JsonMap' : 'Object',
                      ),
                    ]).toJson(),
              );
              break;
          }
        }
      }
    }
    return inferences;
  }

  DartObject? _firstAnnotationOf(
      MapEntry<Type, TypeChecker> check, Element clz) {
    return check.value.firstAnnotationOf(clz, throwOnUnresolved: false);
  }

  InferenceModel _introspect(Map<AssetId, List<JsonMap>> found) {
    final configs = <ConfigModel>[];
    final aggregates = <AnnotationModel>[];
    final annotations = <AnnotationModel>[];
    final ids = <String, Set<AnnotationModel>>{};
    final grpc = <String, Set<AnnotationModel>>{};
    final apps = <String, Set<AnnotationModel>>{};
    final events = <String, Set<AnnotationModel>>{};
    final values = <String, Set<AnnotationModel>>{};
    final states = <String, Set<AnnotationModel>>{};
    final commands = <String, Set<AnnotationModel>>{};

    // Collect annotations in order of appearance
    for (var inferences in found.values) {
      for (var inference in inferences) {
        final type = inference.elementAt<String>('type');
        if (type == '$Eventuous') {
          final annotation = AnnotationModel.fromJson(
            inference,
          );
          configs.add(ConfigModel.fromJson(
            jsonDecode(annotation.valueAt(
              'config',
            )) as Map<String, dynamic>,
          ));
        } else if (type == '$AggregateType') {
          final annotation = AnnotationModel.fromJson(
            inference,
          );
          final duplicate = aggregates.firstWhereOrNull(
              (e) => e.annotationOf == annotation.annotationOf);
          if (duplicate != null) {
            throw InvalidGenerationSourceError(
              '${annotation.type} defined twice '
              'for class ${annotation.annotationOf} in files: \n'
              '- ${duplicate.location?.split(',').join().split(';').first}\n'
              '- ${annotation.location?.split(',').join().split(';').first}',
              todo: 'Only one @AggregateType can be '
                  'defined for each aggregate class name',
            );
          }
          aggregates.add(annotation);
        } else if (type != null) {
          final annotation = AnnotationModel.fromJson(
            inference,
          );
          final aggregate = annotation.valueAt('aggregate');
          switch (inference['type']) {
            case 'GrpcServiceType':
              grpc.update(
                aggregate,
                (items) => items..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'ApplicationType':
              apps.update(
                aggregate,
                (items) => items..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateIdType':
              ids.update(
                aggregate,
                (items) => items..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateEventType':
              events.update(
                aggregate,
                (items) => items..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateValueType':
              values.update(
                aggregate,
                (items) => items..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateStateType':
              states.update(
                aggregate,
                (items) => items..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateCommandType':
              commands.update(
                aggregate,
                (items) => items..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
          }
        } else {
          throw ArgumentError.value(
            inference['type'],
            'type'
            "Inference type not supported.'",
          );
        }
      }
    }

    // Perform introspections on aggregates
    for (var aggregate in aggregates) {
      final json = aggregate.toJson();
      final name = aggregate.annotationOf;
      final id = _ensureOneOrNull(ids, name);
      final params = <ParameterModel>[
        ParameterModel('id', _inferTId(aggregate, ids[name])),
        ParameterModel('data', _inferTData(aggregate, events[name])),
        ParameterModel('event', _inferTEvent(aggregate, events[name])),
        ParameterModel('value', _inferTValue(aggregate, values[name])),
        ParameterModel('state', _inferTState(aggregate, states[name])),
      ];
      json['parameters'] = params.map((e) => e.toJson()).toList();

      // Replace and add updated aggregate
      annotations.add(aggregate = AnnotationModel.fromJson(json));

      // Add grpc, apps, commands, events and values for given aggregate
      annotations.addAll(_replaceParams(grpc, name, params));
      annotations.addAll(_replaceParams(apps, name, params));
      annotations.addAll(commands[name] ?? []);
      annotations.addAll([if (id != null) id]);
      annotations.addAll(events[name] ?? []);
      annotations.addAll(values[name] ?? []);

      // Perform introspections of value type in state of given aggregate
      final state = _ensureOneOrNull(states, name);
      if (state != null) {
        annotations.add(AnnotationModel.fromJson(
          state.toJson()
            ..addAll({
              'parameters': [
                ParameterModel('aggregate', name),
                state.parameterAt('query', 'false'),
                ParameterModel('value', _inferTValue(aggregate, values[name])),
              ].map((e) => e.toJson()).toList(),
            }),
        ));
      }
    }

    if (configs.length > 1) {
      log.warning(
        'Found multiple @Eventuous configurations, '
        'using the first: ${configs.first}',
      );
    }

    return InferenceModel(
      configs.isNotEmpty ? configs.first : ConfigModel.fromJson(_config),
      annotations: annotations,
    );
  }

  AnnotationModel? _ensureOneOrNull(
      Map<String, Set<AnnotationModel>> models, String name) {
    final annotations = models[name] ?? {};
    if (annotations.length > 1) {
      log.severe(
        'Found more than one annotation for $name: \n'
        '* ${annotations.map((a) => '${a.type} annotates '
            '${a.annotationOf} @ ${a.location}').join('\n')}',
      );
    }
    return annotations.isEmpty ? null : annotations.first;
  }

  Iterable<AnnotationModel> _replaceParams(
      Map<String, Set<AnnotationModel>> models,
      String name,
      List<ParameterModel> params) {
    return List<AnnotationModel>.from(models[name] ?? <AnnotationModel>{})
        .map((e) => AnnotationModel.fromJson(e.toJson()
          ..addAll({
            // replace with inferred data if not defined
            'parameters': [...params, ParameterModel('aggregate', name)]
                .map((e) => e.toJson())
                .toList(),
          })));
  }

  String _restrictType(AnnotationModel? model, String name, String type) {
    final parameter = model?.parameterAt(name);
    return parameter?.value.isNotEmpty == true
        ? parameter!.value
        : model?.usesJsonSerializable == true
            ? type
            : 'Object';
  }

  /// Infer AggregateId type
  String _inferTId(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? ids,
  ) {
    return _inferTypeName(
      aggregate,
      'id',
      ids,
      // Use name of annotated aggregate id class
      onInfer: (id) => id.annotationOf,
      // Default name is {{Aggregate}}Id
      onDefault: (_) => '${aggregate.annotationOf}Id',
    );
  }

  String _inferTData(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? events,
  ) {
    // Infers data type from aggregate events if data type not given
    return _inferTypeName(
      aggregate,
      'data',
      events,
      // Data should be JsonMap when json_serializable
      onInfer: (e) => _restrictType(e, 'data', 'JsonMap'),
      onDefault: (e) => _restrictType(e, 'data', 'JsonMap'),
    );
  }

  String _inferTEvent(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? events,
  ) {
    // Infers event type from aggregate events if event type not given
    return _inferTypeName(
      aggregate,
      'event',
      events,
      // Event should be JsonObject when json_serializable
      onInfer: (e) => _restrictType(e, 'event', 'JsonObject'),
      onDefault: (e) => _restrictType(e, 'event', 'JsonObject'),
    );
  }

  String _inferTValue(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? values,
  ) {
    // Infers value type from aggregate values if value type not given
    return _inferTypeName(
      aggregate,
      'value',
      values,
      // Use name of annotated aggregate value class
      onInfer: (value) => value.annotationOf,
      // Default name is {{Aggregate}}Value
      onDefault: (_) => '${aggregate.annotationOf}Value',
    );
  }

  String _inferTState(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? states,
  ) {
    // Infers state type from aggregate states if value type not given
    return _inferTypeName(
      aggregate,
      'state',
      states,
      // Use name of annotated aggregate state class
      onInfer: (state) => state.annotationOf,
      // Default name is {{Aggregate}}State
      onDefault: (_) => '${aggregate.annotationOf}State',
    );
  }

  String _inferTypeName(
    AnnotationModel aggregate,
    String parameterizedTypeName,
    Iterable<AnnotationModel>? candidates, {
    required String Function(AnnotationModel) onInfer,
    required String Function(AnnotationModel?) onDefault,
  }) {
    final parameter = aggregate.parameterAt(parameterizedTypeName);
    final candidate = _findTypeCandidate(parameterizedTypeName, candidates);
    final usesJsonSerializable = candidate?.usesJsonSerializable == true;
    final inferredType = _shouldInfer(parameter)
        ? (eventuous.inferTypes && candidate != null
            ? onInfer(candidate)
            : onDefault(candidate))
        : parameter.value;
    // TODO: Improve inferredType sanity check
    if (usesJsonSerializable && inferredType == 'Object') {
      throw InvalidGenerationSourceError(
        "T${parameterizedTypeName.capitalize()} of type '$inferredType' does not "
        "implement static method 'fromJson'. Please specify $parameterizedTypeName "
        "with the annotation for '${aggregate.annotationOf}.'",
      );
    }
    return inferredType;
  }

  AnnotationModel? _findTypeCandidate(
    String parameterizedTypeName,
    Iterable<AnnotationModel>? candidates,
  ) {
    AnnotationModel? model = candidates?.first;
    if (candidates != null) {
      final types = Set.from(candidates
          .map((e) => e[parameterizedTypeName])
          .whereType<ParameterModel>()
          .map((e) => e.value));

      // Favor parameter value if all are equal
      model = types.length == candidates.length
          // Any type name would do
          ? candidates.first
          // Favor first with json_serializable
          : candidates.firstWhere(
              (e) => e.usesJsonSerializable,
              orElse: () => candidates.first,
            );
    }
    return model;
  }

  bool _shouldInfer(ParameterModel value) =>
      value.value.isEmpty || value.value == 'Object';
}
