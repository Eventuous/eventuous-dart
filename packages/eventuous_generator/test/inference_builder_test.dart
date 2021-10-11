import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:source_gen/source_gen.dart';
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

    test('should throw when @AggregateType is defined twice', () async {
      final result = testBuilder(
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
      await expectLater(result, throwsA(isA<InvalidGenerationSourceError>()));
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
          {'inspect_pattern': 'lib/example.dart'},
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

const AnnotationJsonInferred =
    '''{"type":"AggregateType","annotationOf":"Example","location":"package:test_lib/example.dart;package:test_lib/example.dart;Example","usesJsonSerializable":false,"parameters":[{"name":"id","value":"ExampleId"},{"name":"data","value":"JsonMap"},{"name":"event","value":"JsonObject"},{"name":"value","value":"ExampleValue"},{"name":"state","value":"ExampleState"}]},{"type":"ApplicationType","annotationOf":"ExampleApp","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleApp","usesJsonSerializable":false,"parameters":[{"name":"id","value":"ExampleId"},{"name":"data","value":"JsonMap"},{"name":"event","value":"JsonObject"},{"name":"value","value":"ExampleValue"},{"name":"state","value":"ExampleState"},{"name":"aggregate","value":"Example"}]},{"type":"AggregateCommandType","annotationOf":"CreateExample","location":"package:test_lib/example.dart;package:test_lib/example.dart;CreateExample","usesJsonSerializable":true,"parameters":[{"name":"event","value":"ExampleCreated"},{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"author\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false}]"},{"name":"expected","value":"notExists"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateCommandType","annotationOf":"UpdateExample","location":"package:test_lib/example.dart;package:test_lib/example.dart;UpdateExample","usesJsonSerializable":true,"parameters":[{"name":"event","value":"ExampleUpdated"},{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true}]"},{"name":"expected","value":"exists"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateCommandType","annotationOf":"ImportExample","location":"package:test_lib/example.dart;package:test_lib/example.dart;ImportExample","usesJsonSerializable":true,"parameters":[{"name":"event","value":"ExampleImported"},{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":false,\\"isPositional\\":true,\\"defaultValueCode\\":\\"\'user\'\\"}]"},{"name":"expected","value":"any"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateEventType","annotationOf":"ExampleCreated","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleCreated","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"author\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false}]"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateEventType","annotationOf":"ExampleUpdated","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleUpdated","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true}]"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateEventType","annotationOf":"ExampleImported","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleImported","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":false,\\"isPositional\\":true}]"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateValueType","annotationOf":"ExampleValue","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleValue","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateStateType","annotationOf":"ExampleState","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleState","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"},{"name":"value","value":"ExampleValue"}]}''';

const AnnotationJsonTyped =
    '''{"type":"AggregateType","annotationOf":"Example","location":"package:test_lib/example.dart;package:test_lib/example.dart;Example","usesJsonSerializable":false,"parameters":[{"name":"id","value":"ExampleId1"},{"name":"data","value":"JsonMap"},{"name":"event","value":"JsonObject"},{"name":"value","value":"ExampleStateModel1"},{"name":"state","value":"ExampleState1"}]},{"type":"ApplicationType","annotationOf":"ExampleApp","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleApp","usesJsonSerializable":false,"parameters":[{"name":"id","value":"ExampleId1"},{"name":"data","value":"JsonMap"},{"name":"event","value":"JsonObject"},{"name":"value","value":"ExampleStateModel1"},{"name":"state","value":"ExampleState1"},{"name":"aggregate","value":"Example"}]},{"type":"AggregateCommandType","annotationOf":"CreateExample","location":"package:test_lib/example.dart;package:test_lib/example.dart;CreateExample","usesJsonSerializable":true,"parameters":[{"name":"event","value":"ExampleCreated"},{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"dynamic\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"author\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false}]"},{"name":"expected","value":"notExists"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateCommandType","annotationOf":"UpdateExample","location":"package:test_lib/example.dart;package:test_lib/example.dart;UpdateExample","usesJsonSerializable":true,"parameters":[{"name":"event","value":"ExampleUpdated"},{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true}]"},{"name":"expected","value":"exists"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateCommandType","annotationOf":"ImportExample","location":"package:test_lib/example.dart;package:test_lib/example.dart;ImportExample","usesJsonSerializable":true,"parameters":[{"name":"event","value":"ExampleImported"},{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":false,\\"isPositional\\":true,\\"defaultValueCode\\":\\"\'user\'\\"}]"},{"name":"expected","value":"any"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateEventType","annotationOf":"ExampleCreated","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleCreated","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false},{\\"type\\":\\"String\\",\\"name\\":\\"author\\",\\"isNamed\\":true,\\"isRequired\\":true,\\"isPositional\\":false}]"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateEventType","annotationOf":"ExampleUpdated","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleUpdated","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true}]"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateEventType","annotationOf":"ExampleImported","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleImported","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"constructor","value":"[{\\"type\\":\\"String\\",\\"name\\":\\"exampleId\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String\\",\\"name\\":\\"title\\",\\"isNamed\\":false,\\"isRequired\\":true,\\"isPositional\\":true},{\\"type\\":\\"String?\\",\\"name\\":\\"author\\",\\"isNamed\\":false,\\"isRequired\\":false,\\"isPositional\\":true}]"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateValueType","annotationOf":"ExampleStateModel1","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleStateModel1","usesJsonSerializable":true,"parameters":[{"name":"aggregate","value":"Example"},{"name":"data","value":"JsonMap"}]},{"type":"AggregateStateType","annotationOf":"ExampleState1","location":"package:test_lib/example.dart;package:test_lib/example.dart;ExampleState1","usesJsonSerializable":false,"parameters":[{"name":"aggregate","value":"Example"},{"name":"value","value":"ExampleStateModel1"}]}''';

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
