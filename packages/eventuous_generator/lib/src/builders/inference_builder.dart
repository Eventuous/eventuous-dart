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
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';
import '../helpers.dart';
import 'models/annotation_model.dart';

const Map<Type, TypeChecker> checkers = {
  Eventuous: TypeChecker.fromRuntime(Eventuous),
  AggregateType: TypeChecker.fromRuntime(AggregateType),
  ApplicationType: TypeChecker.fromRuntime(ApplicationType),
  JsonSerializable: TypeChecker.fromRuntime(JsonSerializable),
  AggregateValueType: TypeChecker.fromRuntime(AggregateValueType),
  AggregateEventType: TypeChecker.fromRuntime(AggregateEventType),
  AggregateStateType: TypeChecker.fromRuntime(AggregateStateType),
  AggregateCommandType: TypeChecker.fromRuntime(AggregateCommandType),
};

class InferenceBuilder implements Builder {
  InferenceBuilder(this._config);
  final Map<String, Object?> _config;
  Map<String, Object?> get config {
    return <String, Object?>{
      'infer_types': (_config['infer_types'] ?? true) as bool,
      'lazy_service': (_config['lazy_service'] ?? true) as bool,
      'inspect_path': (_config['inspect_path'] ?? r'$lib$') as String,
      'inspect_pattern': (_config['inspect_pattern'] ?? '**.dart') as String,
    };
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        config.elementAt<String>('inspect_path')!: ['inference.json']
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    if (config.elementAt<bool>('infer_types')!) {
      final inferences = <AssetId, List<JsonMap>>{};
      final inspectPattern = config.elementAt<String>('inspect_pattern')!;

      await for (final input in buildStep.findAssets(Glob(inspectPattern))) {
        final library = await buildStep.resolver.libraryFor(input);
        inferences[input] = await infer(LibraryReader(library), buildStep);
      }

      await buildStep.writeAsString(
        _toInferenceAssetId(buildStep),
        jsonEncode(
          _introspect(inferences).toJson(),
        ),
      );
    }
  }

  Future<List<JsonMap>> infer(
      LibraryReader library, BuildStep buildStep) async {
    final inferences = <JsonMap>[];
    for (var clz in library.classes) {
      for (var check in checkers.entries) {
        if (check.value.hasAnnotationOfExact(clz)) {
          final annotation = _firstAnnotationOf(check, clz);
          final usesJsonSerializable = clz.usesJsonSerializable;
          final reader = ConstantReader(annotation);
          switch (check.key) {
            case Eventuous:
              inferences.add(InferenceModel(ConfigModel.fromJson(
                parseConfig(config, annotation).toJson(),
              )).toJson());
              break;
            case ApplicationType:
              inferences.add(
                AnnotationModel(
                  '$ApplicationType',
                  clz.name,
                  location: clz.location?.encoding,
                  usesJsonSerializable: usesJsonSerializable,
                  parameters: [reader.toTypeModel('aggregate')],
                ).toJson(),
              );
              break;
            case AggregateType:
              inferences.add(
                AnnotationModel('$AggregateType', clz.name,
                    location: clz.location?.encoding,
                    usesJsonSerializable: usesJsonSerializable,
                    parameters: [
                      reader.toTypeModel('id', '${clz.name}Id'),
                      reader.toTypeModel('event'),
                      reader.toTypeModel('value', '${clz.name}Value'),
                      reader.toTypeModel('state', '${clz.name}State'),
                    ]).toJson(),
              );
              break;
            case AggregateValueType:
              inferences.add(
                AnnotationModel('$AggregateValueType', clz.name,
                    location: clz.location?.encoding,
                    usesJsonSerializable: usesJsonSerializable,
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
                    location: clz.location?.encoding,
                    usesJsonSerializable: usesJsonSerializable,
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
                    location: clz.location?.encoding,
                    usesJsonSerializable: usesJsonSerializable,
                    parameters: [
                      reader.toTypeModel('aggregate'),
                      reader.toTypeModel('value', '${clz.name}Value'),
                    ]).toJson(),
              );
              break;
            case AggregateCommandType:
              inferences.add(
                AnnotationModel('$AggregateCommandType', clz.name,
                    location: clz.location?.encoding,
                    usesJsonSerializable: usesJsonSerializable,
                    parameters: [
                      reader.toTypeModel('event'),
                      reader.toTypeModel('aggregate'),
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

  AssetId _toInferenceAssetId(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', 'inference.json'),
    );
  }

  DartObject? _firstAnnotationOf(
      MapEntry<Type, TypeChecker> check, ClassElement clz) {
    return check.value.firstAnnotationOf(clz, throwOnUnresolved: false);
  }

  InferenceModel _introspect(Map<AssetId, List<JsonMap>> found) {
    final configs = <ConfigModel>[];
    final aggregates = <AnnotationModel>[];
    final annotations = <AnnotationModel>[];
    final apps = <String, Set<AnnotationModel>>{};
    final events = <String, Set<AnnotationModel>>{};
    final values = <String, Set<AnnotationModel>>{};
    final states = <String, Set<AnnotationModel>>{};
    final commands = <String, Set<AnnotationModel>>{};

    // Collect annotations in order of appearance
    for (var inferences in found.values) {
      for (var inference in inferences) {
        final type = inference.elementAt<String>('type');
        if (type == 'AggregateType') {
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
            case 'ApplicationType':
              apps.update(
                aggregate,
                (apps) => apps..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateEventType':
              events.update(
                aggregate,
                (events) => events..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateValueType':
              values.update(
                aggregate,
                (values) => values..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateStateType':
              states.update(
                aggregate,
                (states) => states..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
            case 'AggregateCommandType':
              commands.update(
                aggregate,
                (commands) => commands..add(annotation),
                ifAbsent: () => {annotation},
              );
              break;
          }
        } else if (!inference.containsKey('config')) {
          configs.add(ConfigModel.fromJson(
            inference.mapAt<String, dynamic>('config')!,
          ));
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
      final params = <ParameterModel>[
        aggregate['id'] as ParameterModel,
        ParameterModel('data', _inferTData(aggregate, events[name])),
        ParameterModel('event', _inferTEvent(aggregate, events[name])),
        ParameterModel('value', _inferTValue(aggregate, values[name])),
        ParameterModel('state', _inferTState(aggregate, states[name])),
      ];
      json['parameters'] = params.map((e) => e.toJson()).toList();
      annotations.add(AnnotationModel.fromJson(json));

      // Add apps, commands, events and values for given aggregate
      annotations.addAll(
        List<AnnotationModel>.from(apps[name] ?? <AnnotationModel>{})
            .map((e) => AnnotationModel.fromJson(e.toJson()
              ..addAll({
                // replace with inferred data if not defined
                'parameters': [...params, ParameterModel('aggregate', name)]
                    .map((e) => e.toJson())
                    .toList(),
              }))),
      );
      annotations.addAll(commands[name] ?? []);
      annotations.addAll(events[name] ?? []);
      annotations.addAll(values[name] ?? []);

      // Perform introspections of value type in states of given aggregate
      for (var state in (states[name] ?? <AnnotationModel>{})) {
        final json = state.toJson();
        final params = <ParameterModel>[
          ParameterModel('aggregate', name),
          ParameterModel('value', _inferTValue(state, values[name])),
        ];
        json['parameters'] = params.map((e) => e.toJson()).toList();
        annotations.add(AnnotationModel.fromJson(json));
      }
    }

    if (configs.length > 1) {
      log.warning(
        'Found multiple @Eventuous configurations, '
        'using the first: ${configs.first}',
      );
    }

    return InferenceModel(
      configs.isNotEmpty ? configs.first : ConfigModel.fromJson(config),
      annotations: annotations,
    );
  }

  String _inferTData(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? candidates,
  ) {
    return _inferTypeName(aggregate, 'data', candidates,
        onDefault: (usesJsonSerializable) =>
            usesJsonSerializable ? 'JsonMap' : 'Object',
        onInfer: (event) => event.usesJsonSerializable ? 'JsonMap' : 'Object');
  }

  String _inferTEvent(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? events,
  ) {
    return _inferTypeName(aggregate, 'event', events,
        onDefault: (usesJsonSerializable) =>
            usesJsonSerializable ? 'JsonObject' : 'Object',
        onInfer: (event) =>
            event.usesJsonSerializable ? 'JsonObject' : 'Object');
  }

  String _inferTValue(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? values,
  ) {
    return _inferTypeName(aggregate, 'value', values,
        onDefault: (_) => '${aggregate.annotationOf}Value',
        onInfer: (value) => value.annotationOf);
  }

  String _inferTState(
    AnnotationModel aggregate,
    Iterable<AnnotationModel>? states,
  ) {
    return _inferTypeName(aggregate, 'state', states,
        onDefault: (_) => '${aggregate.annotationOf}State',
        onInfer: (state) => state.annotationOf);
  }

  String _inferTypeName(
    AnnotationModel aggregate,
    String parameterName,
    Iterable<AnnotationModel>? candidates, {
    required String Function(bool) onDefault,
    required String Function(AnnotationModel) onInfer,
  }) {
    final state = aggregate[parameterName] as ParameterModel?;
    final usesJsonSerializable = aggregate.usesJsonSerializable ||
        candidates?.any((v) => v.usesJsonSerializable) == true;
    final inferredType = _shouldInfer(state, usesJsonSerializable)
        ? (eventuous.inferTypes && candidates?.isNotEmpty == true
            ? onInfer(candidates!.first)
            : onDefault(usesJsonSerializable))
        : state!.value;
    if (usesJsonSerializable && inferredType == 'Object') {
      throw InvalidGenerationSourceError(
        "T${parameterName.capitalize()} of type '$inferredType' does not "
        "implement static method 'fromJson'. Please specify $parameterName "
        "with the annotation for '${aggregate.annotationOf}.'",
      );
    }
    return inferredType;
  }

  bool _shouldInfer(ParameterModel? value, bool usesJsonSerializable) =>
      value == null || value.value == 'Object' || usesJsonSerializable;
}
