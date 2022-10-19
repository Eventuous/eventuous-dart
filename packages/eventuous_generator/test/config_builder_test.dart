import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:eventuous_generator/src/helpers.dart';
import 'package:test/test.dart';

import 'fakes/helpers.dart';

void main() {
  group('When @Eventuous is given, generator ', () {
    test('should build configuration from defaults', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({})),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
        },
        outputs: {
          'test_lib|lib/eventuous.config.g.part':
              exampleConfigGeneratedSourceDefault,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build configuration with initializer_name given', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({
          'initializer_name': r'_$configureEventuous',
        })),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
        },
        outputs: {
          'test_lib|lib/eventuous.config.g.part':
              exampleConfigGeneratedSourceInitializer,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build configuration with lazy_service=false', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({
          'lazy_service': false,
        })),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
        },
        outputs: {
          'test_lib|lib/eventuous.config.g.part':
              exampleConfigGeneratedSourceNotLazy,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build configuration with @Eventuous(initializerName) given',
        () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({})),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceInitializer,
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            initializeName: r'_$configureEventuous',
            annotations: [exampleAnnotationsJsonDefaults],
          ),
        },
        outputs: {
          'test_lib|lib/eventuous.config.g.part':
              exampleConfigGeneratedSourceInitializer,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build configuration with @Eventuous(lazyService)', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({})),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceNotLazy,
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            lazyService: false,
            annotations: [exampleAnnotationsJsonDefaults],
          ),
        },
        outputs: {
          'test_lib|lib/eventuous.config.g.part':
              exampleConfigGeneratedSourceNotLazy,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should override @Eventuous(initializerName) with initializer_name',
        () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({
          'initializer_name': r'_$initEventuous',
        })),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceInitializer,
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            initializeName: r'_$configureEventuous',
            annotations: [exampleAnnotationsJsonDefaults],
          ),
        },
        outputs: {
          'test_lib|lib/eventuous.config.g.part':
              exampleConfigGeneratedSourceDefault,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should override @Eventuous(lazyService) with lazy_service', () async {
      final result = await testBuilder(
        configBuilder(BuilderOptions({
          'lazy_service': true,
        })),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceNotLazy,
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            lazyService: false,
            annotations: [exampleAnnotationsJsonDefaults],
          ),
        },
        outputs: {
          'test_lib|lib/eventuous.config.g.part':
              exampleConfigGeneratedSourceDefault,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });
  });
}
