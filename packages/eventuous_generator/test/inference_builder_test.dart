import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:eventuous_generator/src/helpers.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'fakes/helpers.dart';

void main() {
  group('When @Eventuous is generated, builder ', () {
    test('should build inference with default config', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/example.dart': exampleSourceInferred,
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
        },
        outputs: {
          'test_lib|lib/inference.json': exampleInferenceJsonInferred,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build inferred types when infer_types=true', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({
          'infer_types': true,
        })),
        {
          'test_lib|lib/example.dart': exampleSourceDefaults,
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
        },
        outputs: {
          'test_lib|lib/inference.json': exampleInferenceJsonInferred,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build default types when infer_types=false', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({
          'infer_types': false,
        })),
        {
          'test_lib|lib/example.dart': exampleSourceDefaults,
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
        },
        outputs: {
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build given types when infer_types=true', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({
          'infer_types': true,
        })),
        {
          'test_lib|lib/example.dart': exampleSourceGiven,
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
        },
        outputs: {
          'test_lib|lib/inference.json': exampleInferenceJsonGiven,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build given types when infer_types=false', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({
          'infer_types': false,
        })),
        {
          'test_lib|lib/example.dart': exampleSourceGiven,
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
        },
        outputs: {
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            inferTypes: false,
            annotations: [exampleAnnotationsJsonGiven],
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build default eventuous config', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/example.dart': exampleSourceGiven,
          // inferTypes is default true (unspecified)
          'test_lib|eventuous.dart': exampleConfigSourceDefault,
        },
        outputs: {
          // example with given types implies inferTypes is true
          'test_lib|lib/inference.json': exampleInferenceJsonGiven,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build eventuous config from @Eventuous(initializerName)',
        () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceInitializer,
        },
        outputs: {
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            initializeName: r'_$configureEventuous',
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build eventuous config from @Eventuous(lazyService)',
        () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/eventuous.dart': exampleConfigSourceNotLazy,
        },
        outputs: {
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            lazyService: false,
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should override @Eventuous(initializerName) with initializer_name',
        () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({
          'initializer_name': r'_$initEventuous',
        })),
        {
          'test_lib|lib/example.dart': exampleSourceGiven,
          'test_lib|lib/eventuous.dart': exampleConfigSourceInitializer,
        },
        outputs: {
          'test_lib|lib/inference.json': exampleInferenceJsonGiven,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should override @Eventuous(lazyService) with lazy_service', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions({
          'lazy_service': true,
        })),
        {
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
          'test_lib|lib/eventuous.dart': exampleConfigSourceNotLazy,
        },
        outputs: {
          'test_lib|lib/inference.json': toInferenceJsonAsString(),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build inference with specified path', () async {
      final result = await testBuilder(
        inferenceBuilder(BuilderOptions(
          {'inspect_pattern': 'lib/example.dart'},
        )),
        {
          'test_lib|lib/example.dart': exampleSourceInferred,
          // This should not throw InvalidGenerationSourceError
          'test_lib|lib/example/example.dart': exampleSourceInferred,
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
        },
        outputs: {
          'test_lib|lib/inference.json': exampleInferenceJsonInferred,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should throw when @AggregateType is defined twice', () async {
      final result = testBuilder(
        inferenceBuilder(BuilderOptions({})),
        {
          'test_lib|lib/example.dart': exampleSourceInferred,
          'test_lib|lib/eventuous.dart': exampleConfigSourceDefault,
          'test_lib|lib/example/example.dart': exampleSourceGiven,
        },
        outputs: {
          'test_lib|lib/inference.json': toInferenceJsonAsString(
            inferTypes: true,
            annotations: [
              exampleAnnotationsJsonGiven,
              exampleAnnotationsJsonInferred,
            ],
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      await expectLater(result, throwsA(isA<InvalidGenerationSourceError>()));
    });
  });
}
