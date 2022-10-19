import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:test/test.dart';

import 'fakes/helpers.dart';

void main() {
  group('When @GrpcServiceType is given, generator', () {
    test('should build proto from defaults', () async {
      final result = await testBuilder(
        grpcSpecBuilder(BuilderOptions({})),
        {
          'test_lib|lib/src/example.dart': exampleSourceDefaults,
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
        },
        outputs: {
          'test_lib|protos/src/example.proto': exampleProtoDefault,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build proto from inferred', () async {
      // Sanity check
      expect(
        exampleProtoDefault,
        equals(exampleProtoInferred),
        reason: 'Test assumption: default yields same proto as inferred',
      );

      final result = await testBuilder(
        grpcSpecBuilder(BuilderOptions({})),
        {
          'test_lib|lib/src/example.dart': exampleSourceInferred,
          'test_lib|lib/inference.json': exampleInferenceJsonInferred,
        },
        outputs: {
          'test_lib|protos/src/example.proto': exampleProtoInferred,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build proto from given', () async {
      final result = await testBuilder(
        grpcSpecBuilder(BuilderOptions({})),
        {
          'test_lib|lib/src/example.dart': exampleSourceGiven,
          'test_lib|lib/inference.json': exampleInferenceJsonGiven,
        },
        outputs: {
          'test_lib|protos/src/example.proto': exampleProtoGiven,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should build proto with build_extensions', () async {
      final result = await testBuilder(
        grpcSpecBuilder(BuilderOptions({
          'build_extensions': {
            '^src1/{{}}.dart': ['protos/{{}}1.proto'],
            '^src2/{{}}.dart': ['protos/{{}}2.proto']
          }
        })),
        {
          'test_lib|src1/example.dart': exampleSourceDefaults,
          'test_lib|src2/example.dart': exampleSourceDefaults,
          'test_lib|lib/inference.json': exampleInferenceJsonDefaults,
        },
        outputs: {
          'test_lib|protos/example1.proto': exampleProtoDefault,
          'test_lib|protos/example2.proto': exampleProtoDefault,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });
  });
}
