import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:test/test.dart';

void main() {
  group('When @Eventuous is given, generator should ', () {
    test('create configuration with default initializer', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({})),
        {
          'test_lib|eventuous.dart': ConfigSourceCodeDefaults,
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
import 'package:test_lib/example.dart';

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

const ConfigGeneratedCodeDefaults = '''
// **************************************************************************
// ConfigGenerator
// **************************************************************************

void _\$initEventuous(GetIt getIt) {
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
}
''';

const ConfigGeneratedCodeInitializerGiven = '''
// **************************************************************************
// ConfigGenerator
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
}
''';
