import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:eventuous_generator/eventuous_generator.dart';
import 'package:test/test.dart';

import 'inference_builder_test.dart';

void main() {
  group('When @AggregateType is given, generator', () {
    test('should create aggregate with default types', () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({'infer_types': false})),
        {
          'test_lib|example.dart': ExampleSourceCodeDefaults,
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonDefaults',
        },
        outputs: {
          'test_lib|example.aggregate.g.part': ExampleGeneratedCodeDefaults,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should create aggregate with types inferred', () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({'infer_types': true})),
        {
          'test_lib|example.dart': ExampleSourceCodeDefaults,
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonInferred',
        },
        outputs: {
          'test_lib|example.aggregate.g.part': ExampleGeneratedCodeInferred,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should create aggregate with types and inferred == true', () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({'infer_types': true})),
        {
          'test_lib|example.dart': ExampleSourceCodeTyped,
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonTyped',
        },
        outputs: {
          'test_lib|example.aggregate.g.part': ExampleGeneratedCodeTyped,
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
      expect(result, isNull);
    });

    test('should create aggregate with types and inferred == false', () async {
      final result = await testBuilder(
        codeBuilder(BuilderOptions({'infer_types': false})),
        {
          'test_lib|example.dart': ExampleSourceCodeTyped,
          'test_lib|lib/inference.json': '$InferenceGeneratedJsonTyped',
        },
        outputs: {
          'test_lib|example.aggregate.g.part': ExampleGeneratedCodeTyped,
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

part 'example.aggregate.dart';

@AggregateType()
class Example extends _$Example {}

@JsonSerializable()
@AggregateValueType(Example)
class ExampleValue extends _$ExampleValue {
  ExampleValue() : super([]);
}

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

part 'example.aggregate.dart';

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

@AggregateCommandType(Example)
class CreateExample extends _$CreateExample {}

@JsonSerializable()
@AggregateEventType(Example, data: JsonMap)
class ExampleCreated extends _$ExampleCreated {
  ExampleCreated() : super([]);
}
''';

const ExampleGeneratedCodeDefaults = '''
// **************************************************************************
// AggregateGenerator
// **************************************************************************

abstract class _\$Example
    extends Aggregate<Object, ExampleValue, ExampleId, ExampleState> {
  _\$Example(ExampleId id, ExampleState? state)
      : super(id, state ?? ExampleState()) {
    AggregateTypes.define<Object, ExampleValue, ExampleId, ExampleState,
        Example>(
      (id, [state]) => Example(id, state),
    );
  }
  // ignore: unused_element
  static Example from(String id) => Example(ExampleId(id));
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _\$ExampleCreated extends JsonObject {
  _\$ExampleCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<Object, ExampleCreated>(
      _\$ExampleCreated.fromJson,
    );
  }

  static ExampleCreated fromJson(Object json) => _\$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _\$ExampleCreatedToJson(this as ExampleCreated);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _\$ExampleValue extends JsonObject {
  _\$ExampleValue(List<Object?> props) : super(props) {
    AggregateValueTypes.define<Object, ExampleValue>(
      _\$ExampleValue.fromJson,
    );
  }

  static ExampleValue fromJson([Object? json]) =>
      _\$ExampleValueFromJson(json ?? {});

  @override
  JsonMap toJson() => _\$ExampleValueToJson(this as ExampleValue);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _\$ExampleState extends AggregateState<ExampleValue> {
  _\$ExampleState(ExampleValue? value, int? version)
      : super(value ?? ExampleValue(), version) {
    AggregateStateTypes.define<ExampleValue, ExampleState>(
      ([value, version]) => ExampleState(value, version),
    );
    on<ExampleCreated>(patch);
  }

  ExampleState patch(Object event, ExampleValue value) {
    return ExampleState(AggregateValueTypes.create<JsonMap, ExampleValue>(
      JsonUtils.patch(
        value,
        event,
      ),
    ));
  }
}
''';

const ExampleGeneratedCodeInferred = '''
// **************************************************************************
// AggregateGenerator
// **************************************************************************

abstract class _\$Example
    extends Aggregate<JsonObject, ExampleValue, ExampleId, ExampleState> {
  _\$Example(ExampleId id, ExampleState? state)
      : super(id, state ?? ExampleState()) {
    AggregateTypes.define<JsonObject, ExampleValue, ExampleId, ExampleState,
        Example>(
      (id, [state]) => Example(id, state),
    );
  }
  // ignore: unused_element
  static Example from(String id) => Example(ExampleId(id));
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _\$ExampleCreated extends JsonObject {
  _\$ExampleCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleCreated>(
      _\$ExampleCreated.fromJson,
    );
  }

  static ExampleCreated fromJson(JsonMap json) =>
      _\$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _\$ExampleCreatedToJson(this as ExampleCreated);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _\$ExampleValue extends JsonObject {
  _\$ExampleValue(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, ExampleValue>(
      _\$ExampleValue.fromJson,
    );
  }

  static ExampleValue fromJson([JsonMap? json]) =>
      _\$ExampleValueFromJson(json ?? {});

  @override
  JsonMap toJson() => _\$ExampleValueToJson(this as ExampleValue);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _\$ExampleState extends AggregateState<ExampleValue> {
  _\$ExampleState(ExampleValue? value, int? version)
      : super(value ?? ExampleValue(), version) {
    AggregateStateTypes.define<ExampleValue, ExampleState>(
      ([value, version]) => ExampleState(value, version),
    );
    on<ExampleCreated>(patch);
  }

  ExampleState patch(JsonObject event, ExampleValue value) {
    return ExampleState(AggregateValueTypes.create<JsonMap, ExampleValue>(
      JsonUtils.patch(
        value,
        event,
      ),
    ));
  }
}
''';

const ExampleGeneratedCodeTyped = '''
// **************************************************************************
// AggregateGenerator
// **************************************************************************

abstract class _\$Example extends Aggregate<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1> {
  _\$Example(ExampleId1 id, ExampleState1? state)
      : super(id, state ?? ExampleState1()) {
    AggregateTypes.define<JsonObject, ExampleStateModel1, ExampleId1,
        ExampleState1, Example>(
      (id, [state]) => Example(id, state),
    );
  }
  // ignore: unused_element
  static Example from(String id) => Example(ExampleId1(id));
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _\$ExampleCreated extends JsonObject {
  _\$ExampleCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleCreated>(
      _\$ExampleCreated.fromJson,
    );
  }

  static ExampleCreated fromJson(JsonMap json) =>
      _\$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _\$ExampleCreatedToJson(this as ExampleCreated);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _\$ExampleStateModel1 extends JsonObject {
  _\$ExampleStateModel1(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, ExampleStateModel1>(
      _\$ExampleStateModel1.fromJson,
    );
  }

  static ExampleStateModel1 fromJson([JsonMap? json]) =>
      _\$ExampleStateModel1FromJson(json ?? {});

  @override
  JsonMap toJson() => _\$ExampleStateModel1ToJson(this as ExampleStateModel1);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _\$ExampleState1 extends AggregateState<ExampleStateModel1> {
  _\$ExampleState1(ExampleStateModel1? value, int? version)
      : super(value ?? ExampleStateModel1(), version) {
    AggregateStateTypes.define<ExampleStateModel1, ExampleState1>(
      ([value, version]) => ExampleState1(value, version),
    );
    on<ExampleCreated>(patch);
  }

  ExampleState1 patch(JsonObject event, ExampleStateModel1 value) {
    return ExampleState1(
        AggregateValueTypes.create<JsonMap, ExampleStateModel1>(
      JsonUtils.patch(
        value,
        event,
      ),
    ));
  }
}
''';
