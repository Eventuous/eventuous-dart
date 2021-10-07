import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:test/test.dart';

import 'code_generator_test.dart';

void main() {
  group('When @Eventuous is generated, builder ', () {
    test('should build inference by default', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/example.dart': ExampleSourceCodeDefaults,
        },
        outputs: {
          'test_lib|lib/inference.json': '{"config":{"infer_types":true,'
              '"initialize_name":"_\$initEventuous"},'
              '"annotations":[$AnnotationJsonInferred]}',
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build inference from specified types', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/example.dart': ExampleSourceCodeTyped,
        },
        outputs: {
          'test_lib|lib/inference.json': '{"config":{"infer_types":true,'
              '"initialize_name":"_\$initEventuous"},'
              '"annotations":[$AnnotationJsonTyped]}',
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build inference from defaults in all files', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/example.dart': ExampleSourceCodeDefaults,
          'test_lib|lib/eventuous.dart': InferenceSourceCodeDefaults,
          'test_lib|lib/example/example.dart': ExampleSourceCodeTyped,
        },
        outputs: {
          'test_lib|lib/inference.json': '{"config":{"infer_types":true,'
              '"initialize_name":"_\$initEventuous"},'
              '"annotations":[$AnnotationJsonInferred,$AnnotationJsonTyped]}',
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build inference data with default path', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/example.dart': ExampleSourceCodeDefaults,
          'test_lib|lib/eventuous.dart': InferenceSourceCodeDefaults,
        },
        outputs: {
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonInferred',
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build inference data with specified path', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions(
          {'inspect_pattern': 'lib/example/**'},
        )),
        {
          'test_lib|lib/example.dart': ExampleSourceCodeDefaults,
          'test_lib|lib/eventuous.dart': InferenceSourceCodeDefaults,
          'test_lib|lib/example/example.dart': ExampleSourceCodeDefaults,
        },
        outputs: {
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonInferred'
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should not build inference data when infer_types==false', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({'infer_types': false})),
        {
          'test_lib|lib/example.dart': ExampleSourceCodeDefaults,
          'test_lib|lib/eventuous.dart': InferenceSourceCodeDefaults,
          'test_lib|lib/example/example.dart': ExampleSourceCodeDefaults,
        },
        outputs: {},
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });
  });
}

const InferenceSourceCodeDefaults = '''
import 'package:eventuous/eventuous.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_lib/example.dart';

part 'eventuous.g.dart';

final getIt = GetIt.instance;

@Eventuous()
void initEventuous() => _\$initEventuous(getId);
''';

const InferenceSourceCodeInitializerGiven = '''
import 'package:eventuous/eventuous.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';

part 'eventuous.g.dart';

final getIt = GetIt.instance;

@Eventuous(
  initializerName: r'_\$configureEventuous',
)
void initEventuous() => _\$configureEventuous(getId);
''';

const AnnotationJsonDefaults =
    '''{"type":"AggregateType","annotationOf":"Example","usesJsonSerializable":false,"parameters":[{"name":"id","value":"ExampleId"},{"name":"event","value":"Object"},{"name":"value","value":"ExampleValue"},{"name":"state","value":"ExampleState"}]},{"type":"AggregateEventType","annotationOf":"ExampleCreated","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"Object"}]},{"type":"AggregateValueType","annotationOf":"ExampleValue","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"Object"}]},{"type":"AggregateStateType","annotationOf":"ExampleState","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"},{"name":"value","value":"ExampleValue"}]},{"type":"AggregateCommandType","annotationOf":"CreateExample","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"}]}''';

const AnnotationJsonInferred =
    '''{"type":"AggregateType","annotationOf":"Example","usesJsonSerializable":false,"parameters":[{"name":"id","value":"ExampleId"},{"name":"event","value":"JsonObject"},{"name":"value","value":"ExampleValue"},{"name":"state","value":"ExampleState"}]},{"type":"AggregateEventType","annotationOf":"ExampleCreated","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateValueType","annotationOf":"ExampleValue","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateStateType","annotationOf":"ExampleState","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"},{"name":"value","value":"ExampleValue"}]},{"type":"AggregateCommandType","annotationOf":"CreateExample","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"}]}''';

const AnnotationJsonTyped =
    '''{"type":"AggregateType","annotationOf":"Example","usesJsonSerializable":false,"parameters":[{"name":"id","value":"ExampleId1"},{"name":"event","value":"JsonObject"},{"name":"value","value":"ExampleStateModel1"},{"name":"state","value":"ExampleState1"}]},{"type":"AggregateEventType","annotationOf":"ExampleCreated","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateValueType","annotationOf":"ExampleStateModel1","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateStateType","annotationOf":"ExampleState1","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"},{"name":"value","value":"ExampleStateModel1"}]},{"type":"AggregateCommandType","annotationOf":"CreateExample","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"}]}''';

const InferenceGeneratedJsonDefaults = '''
{"config":{"infer_types":true,"initialize_name":"_\$initEventuous"},"annotations":[$AnnotationJsonDefaults]}''';

const InferenceGeneratedJsonInferred = '''
{"config":{"infer_types":true,"initialize_name":"_\$initEventuous"},"annotations":[$AnnotationJsonInferred]}''';

const InferenceGeneratedJsonTyped = '''
{"config":{"infer_types":false,"initialize_name":"_\$initEventuous"},"annotations":[$AnnotationJsonTyped]}''';

const InferenceGeneratedCodeInitializerGiven = '''
// **************************************************************************
// EventuousConfigGenerator
// **************************************************************************

void _\$configureEventuous(GetIt getIt) {
  \$Eventuous.init();
}

typedef EventuousInitCallback = void Function();

class \$Eventuous {
  static final _callbacks = <EventuousInitCallback>{};
  static void init() {
    for (var callback in _callbacks) {
      callback();
    }
  }

  static void onInit(EventuousInitCallback callback) =>
      _callbacks.add(callback);
''';
