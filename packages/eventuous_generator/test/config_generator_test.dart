import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:test/test.dart';

import 'inference_builder_test.dart';

void main() {
  group('When @Eventuous is given, generator should ', () {
    test('create configuration with default initializer', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({})),
        {
          'test_lib|eventuous.dart': ConfigSourceCodeDefaults,
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonInferred',
        },
        outputs: {
          'test_lib|eventuous.config.g.part': ConfigGeneratedCodeDefaults,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });
    test('create configuration with given initializer', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({
          'initializerName': '_\$configureEventuous',
        })),
        {
          'test_lib|eventuous.dart': ConfigSourceCodeInitializerGiven,
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonInferred',
        },
        outputs: {
          'test_lib|eventuous.config.g.part':
              ConfigGeneratedCodeInitializerGiven,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });
  });
}

const ConfigSourceCodeDefaults = '''
import 'package:eventuous/eventuous.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_lib/foo.dart';

part 'eventuous.g.dart';

final getIt = GetIt.instance;

@Eventuous()
void initEventuous() => _\$initEventuous(getId);
''';

const ConfigSourceCodeInitializerGiven = '''
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

const ConfigGeneratedCodeDefaults = r'''
// **************************************************************************
// ConfigGenerator
// **************************************************************************

GetIt _$initEventuous(StreamEventStore eventStore) {
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<ExampleApp>(
    () => ExampleApp(ExampleStore(
      eventStore,
      onNew: (id, [state]) => Example(id, state),
    )),
  );

  return getIt;
}
''';

const ConfigGeneratedCodeInitializerGiven = r'''
// **************************************************************************
// ConfigGenerator
// **************************************************************************

GetIt _$configureEventuous(StreamEventStore eventStore) {
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<ExampleApp>(
    () => ExampleApp(ExampleStore(
      eventStore,
      onNew: (id, [state]) => Example(id, state),
    )),
  );

  return getIt;
}
''';
