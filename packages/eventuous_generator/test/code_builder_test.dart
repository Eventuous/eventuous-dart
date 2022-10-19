import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:test/test.dart';

import 'fakes/helpers.dart';

void main() {
  group('When @AggregateType is given, generator', () {
    test('should build aggregate with default types', () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({
          // This should result in default types being generated
          'infer_types': false,
        })),
        {
          'test_lib|example.dart': exampleSourceDefaults,
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
        },
        outputs: {
          'test_lib|example.aggregate.g.part': exampleGeneratedSourceDefaults,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build aggregate with inferred types', () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({'infer_types': true})),
        {
          'test_lib|example.dart': exampleSourceDefaults,
          'test_lib|lib/inference.json': exampleInferenceJsonGiven,
        },
        outputs: {
          'test_lib|example.aggregate.g.part': exampleGeneratedSourceInferred,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build aggregate with given types when infer_types=true',
        () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({'infer_types': true})),
        {
          'test_lib|example.dart': exampleSourceGiven,
          'test_lib|lib/inference.json': exampleInferenceJsonGiven,
        },
        outputs: {
          'test_lib|example.aggregate.g.part': exampleGeneratedSourceGiven,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build aggregate with given types when infer_types=false',
        () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({'infer_types': false})),
        {
          'test_lib|example.dart': exampleSourceGiven,
          'test_lib|lib/inference.json': exampleInferenceJsonGiven,
        },
        outputs: {
          'test_lib|example.aggregate.g.part': exampleGeneratedSourceGiven,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });
  });
}
