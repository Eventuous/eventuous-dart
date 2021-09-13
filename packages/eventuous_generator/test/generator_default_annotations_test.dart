import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/builder.dart';
import 'package:test/test.dart';

void main() {
  group('When default annotations are given, generator should ', () {
    test('create aggregate with default types', () async {
      final result = await testBuilder(
        eventuous(BuilderOptions({'infer_types': false})),
        {
          'test_lib|example.dart': ExampleSourceCodeDefaults,
        },
        outputs: {
          'test_lib|example.eventuous.dart': ExampleGeneratedCodeDefaults,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('create aggregate with types inferred', () async {
      final result = await testBuilder(
        eventuous(BuilderOptions({'infer_types': true})),
        {
          'test_lib|example.dart': ExampleSourceCodeDefaults,
        },
        outputs: {
          'test_lib|example.eventuous.dart': ExampleGeneratedCodeInferred,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('create aggregate with types and inferred == true', () async {
      final result = await testBuilder(
        eventuous(BuilderOptions({'infer_types': true})),
        {
          'test_lib|example.dart': ExampleSourceCodeTyped,
        },
        outputs: {
          'test_lib|example.eventuous.dart': ExampleGeneratedCodeTyped,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('create aggregate with types and inferred == false', () async {
      final result = await testBuilder(
        eventuous(BuilderOptions({'infer_types': false})),
        {
          'test_lib|example.dart': ExampleSourceCodeTyped,
        },
        outputs: {
          'test_lib|example.eventuous.dart': ExampleGeneratedCodeTyped,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });
  });
}

const ExampleSourceCodeDefaults = r'''
import 'package:eventuous/eventuous.dart';
import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.eventuous.dart';

@AggregateType()
class Example extends _$Example {}

@JsonSerializable()
@AggregateStateType(Example)
class ExampleState extends _$ExampleState {}

@AggregateCommandType(Example)
class CreateExample extends _$CreateExample {}

@JsonSerializable()
@AggregateEventType(Example)
class ExampleCreated extends _$ExampleCreated {}
''';

const ExampleSourceCodeTyped = r'''
import 'package:eventuous/eventuous.dart';
import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.eventuous.dart';

@AggregateType(
  id: ExampleId1,
  event: JsonObject,
  state: ExampleState1,
  value: ExampleStateModel1,
)
class Example extends _$Example {
  Example(ExampleId1 id, [ExampleState1? state]) : super(id, state);
}

class ExampleId1 extends AggregateId {
  ExampleId1(String id) : super(id);
}

@JsonSerializable()
@AggregateValueType(Example, data: JsonMap)
class ExampleStateModel1 extends _$ExampleStateModel1 {
  ExampleStateModel1() : super([]);
}

@AggregateStateType(Example, value: ExampleStateModel1)
class ExampleState1 extends _$ExampleState1 {
  ExampleState1([ExampleStateModel1? value, int? version])
      : super(value, version);
}

@JsonSerializable()
@AggregateEventType(Example, data: JsonMap)
class ExampleCreated extends _$ExampleCreated {
  ExampleCreated() : super([]);
}
''';

const Header = r'''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target
''';

const ExampleGeneratedCodeDefaults = '''
$Header
part of 'example.dart';

// **************************************************************************
// EventuousGenerator
// **************************************************************************

abstract class _\$Example
    extends Aggregate<Object, Object, ExampleId, ExampleState> {
  _\$Example(ExampleId id, ExampleState? state)
      : super(id, state ?? ExampleState());
  static Example from(String id) => Example(ExampleId(id));
}

abstract class _\$ExampleState extends AggregateState<Object> {
  _\$ExampleState(Object? value, int? version)
      : super(value ?? Object(), version);
}

abstract class _\$ExampleCreated extends JsonObject {
  _\$ExampleCreated(List<Object?> props) : super(props);

  static ExampleCreated fromJson(JsonMap json) =>
      _\$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _\$ExampleCreatedToJson(this as ExampleCreated);
}

void defineExampleTypes() {
  AggregateTypes.define<Object, Object, ExampleId, ExampleState, Example>(
      (id, [state]) => Example(id, state));
  AggregateStateTypes.define<Object, ExampleState>(
    ([value, version]) => ExampleState(value, version),
  );
  AggregateEventTypes.define<JsonMap, ExampleCreated>(
    (data) => _\$ExampleCreated.fromJson(data),
  );
}
''';

const ExampleGeneratedCodeInferred = '''
$Header
part of 'example.dart';

// **************************************************************************
// EventuousGenerator
// **************************************************************************

abstract class _\$Example
    extends Aggregate<Object, ExampleValue, ExampleId, ExampleState> {
  _\$Example(ExampleId id, ExampleState? state)
      : super(id, state ?? ExampleState());
  static Example from(String id) => Example(ExampleId(id));
}

abstract class _\$ExampleState extends AggregateState<ExampleValue> {
  _\$ExampleState(ExampleValue? value, int? version)
      : super(value ?? ExampleValue(), version);
}

abstract class _\$ExampleCreated extends JsonObject {
  _\$ExampleCreated(List<Object?> props) : super(props);

  static ExampleCreated fromJson(JsonMap json) =>
      _\$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _\$ExampleCreatedToJson(this as ExampleCreated);
}

void defineExampleTypes() {
  AggregateTypes.define<Object, ExampleValue, ExampleId, ExampleState, Example>(
      (id, [state]) => Example(id, state));
  AggregateStateTypes.define<ExampleValue, ExampleState>(
    ([value, version]) => ExampleState(value, version),
  );
  AggregateEventTypes.define<JsonMap, ExampleCreated>(
    (data) => _\$ExampleCreated.fromJson(data),
  );
}
''';

const ExampleGeneratedCodeTyped = '''
$Header
part of 'example.dart';

// **************************************************************************
// EventuousGenerator
// **************************************************************************

abstract class _\$Example extends Aggregate<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1> {
  _\$Example(ExampleId1 id, ExampleState1? state)
      : super(id, state ?? ExampleState1());
  static Example from(String id) => Example(ExampleId1(id));
}

abstract class _\$ExampleStateModel1 extends JsonObject {
  _\$ExampleStateModel1(List<Object?> props) : super(props);

  static ExampleStateModel1 fromJson(JsonMap json) =>
      _\$ExampleStateModel1FromJson(json);

  @override
  JsonMap toJson() => _\$ExampleStateModel1ToJson(this as ExampleStateModel1);
}

abstract class _\$ExampleState1 extends AggregateState<ExampleStateModel1> {
  _\$ExampleState1(ExampleStateModel1? value, int? version)
      : super(value ?? ExampleStateModel1(), version);
}

abstract class _\$ExampleCreated extends JsonObject {
  _\$ExampleCreated(List<Object?> props) : super(props);

  static ExampleCreated fromJson(JsonMap json) =>
      _\$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _\$ExampleCreatedToJson(this as ExampleCreated);
}

void defineExampleTypes() {
  AggregateTypes.define<JsonObject, ExampleStateModel1, ExampleId1,
      ExampleState1, Example>((id, [state]) => Example(id, state));
  AggregateStateTypes.define<ExampleStateModel1, ExampleState1>(
    ([value, version]) => ExampleState1(value, version),
  );
  AggregateEventTypes.define<JsonMap, ExampleCreated>(
    (data) => _\$ExampleCreated.fromJson(data),
  );
}
''';
