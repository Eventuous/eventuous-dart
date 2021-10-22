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
          'test_lib|lib/inference.json': InferenceGeneratedJsonDefaults,
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
          'test_lib|lib/inference.json': InferenceGeneratedJsonInferred,
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
          'test_lib|lib/inference.json': InferenceGeneratedJsonTyped,
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
          'test_lib|lib/inference.json': InferenceGeneratedJsonTyped,
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

const InferenceGeneratedJsonDefaults = r'''
{"config":{"infer_types":true,"initialize_name":"_$initEventuous"},"annotations":[]}''';

const ExampleSourceCodeDefaults = r'''
import 'package:eventuous/eventuous.dart';
import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.aggregate.dart';

@ApplicationType(Example)
class ExampleApp extends _$ExampleApp {
  ExampleApp(ExampleStore store) : super(store);
}

@AggregateType()
class Example extends _$Example {}

@JsonSerializable()
@AggregateValueType(Example)
class ExampleValue extends _$ExampleValue {
  ExampleValue(this.title,this.author) : super([title,author]);
  final String title;
  final String author;
}

@AggregateStateType(Example)
class ExampleState extends _$ExampleState {}

@JsonSerializable()
@AggregateCommandType(Example, ExampleCreated, expected: ExpectedState.notExists)
class CreateExample extends _$CreateExample {
  CreateExample({
    required this.exampleId,
    required this.title,
    required this.author,
  }) : super([ExampleId, title, author]);
  final String exampleId;
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateCommandType(Example, ExampleUpdated, expected: ExpectedState.exists)
class UpdateExample extends _$UpdateExample {
  UpdateExample(this.exampleId, this.title, this.author)
      : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateCommandType(Example, ExampleImported)
class ImportExample extends _$ImportExample {
  ImportExample(this.exampleId, this.title, [this.author = 'user'])
      : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateEventType(Example)
class ExampleCreated extends _$ExampleCreated {
  ExampleCreated({
    required this.exampleId,
    required this.title,
    required this.author,
  }) : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateEventType(Example)
class ExampleUpdated extends _$ExampleUpdated {
  ExampleUpdated(
    this.exampleId,
    this.title,
    this.author,
  ) : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;  
}

@JsonSerializable()
@AggregateEventType(Example)
class ExampleImported extends _$ExampleImported {
  ExampleImported(this.exampleId, this.title, [this.author])
      : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;
}
''';

const ExampleSourceCodeTyped = r'''
import 'package:eventuous/eventuous.dart';
import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.aggregate.dart';

@ApplicationType(
  Example,
  id: ExampleId1,
  event: JsonObject,
  state: ExampleState1,
  value: ExampleStateModel1,
)
class ExampleApp extends _$ExampleApp {
  ExampleApp(ExampleStore store) : super(store);
}

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
  ExampleStateModel1(this.title,this.author) : super([title,author]);
  final String title;
  final String author;
}

@AggregateStateType(Example, value: ExampleStateModel1)
class ExampleState1 extends _$ExampleState1 {
  ExampleState1([ExampleStateModel1? value, int? version])
      : super(value, version);
}

@JsonSerializable()
@AggregateCommandType(Example, ExampleCreated, expected: ExpectedState.notExists)
class CreateExample extends _$CreateExample {
  CreateExample({
    required this.exampleId,
    required this.title,
    required this.author,
  }) : super([ExampleId, title, author]);
  final String ExampleId;
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateCommandType(Example, ExampleUpdated, expected: ExpectedState.exists)
class UpdateExample extends _$UpdateExample {
  UpdateExample(this.exampleId, this.title, this.author)
      : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateCommandType(Example, ExampleImported)
class ImportExample extends _$ImportExample {
  ImportExample(this.exampleId, this.title, [this.author = 'user'])
      : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateEventType(Example)
class ExampleCreated extends _$ExampleCreated {
  ExampleCreated({
    required this.exampleId,
    required this.title,
    required this.author,
  }) : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateEventType(Example, data: JsonMap)
class ExampleUpdated extends _$ExampleUpdated {
  ExampleUpdated(
    this.exampleId,
    this.title,
    this.author,
  ) : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateEventType(Example, data: JsonMap)
class ExampleImported extends _$ExampleImported {
  ExampleImported(this.exampleId, this.title, [this.author])
      : super([exampleId, title, author]);
  final String exampleId;
  final String title;
  final String? author;
}
''';

const ExampleGeneratedCodeDefaults = r'''
// **************************************************************************
// AggregateGenerator
// **************************************************************************

typedef ExampleStore = AggregateStore<Object, Object, ExampleValue, ExampleId,
    ExampleState, Example>;

typedef ExampleStateResult
    = AggregateStateResult<Object, ExampleValue, ExampleId, ExampleState>;

typedef ExampleStateOk
    = AggregateStateOk<Object, ExampleValue, ExampleId, ExampleState>;

typedef ExampleStateError
    = AggregateStateError<Object, ExampleValue, ExampleId, ExampleState>;

typedef ExampleStateNoOp
    = AggregateStateNoOp<Object, ExampleValue, ExampleId, ExampleState>;

abstract class _$Example
    extends Aggregate<Object, ExampleValue, ExampleId, ExampleState> {
  _$Example(ExampleId id, ExampleState? state)
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
// ApplicationGenerator
// **************************************************************************

typedef ExampleResult = AggregateCommandResult<Object, ExampleValue, ExampleId,
    ExampleState, Example>;

typedef ExampleOk = AggregateCommandOkResult<Object, ExampleValue, ExampleId,
    ExampleState, Example>;

typedef ExampleError = AggregateCommandErrorResult<Object, ExampleValue,
    ExampleId, ExampleState, Example>;

abstract class _$ExampleApp extends ApplicationServiceBase<Object, Object,
    ExampleValue, ExampleId, ExampleState, Example> {
  _$ExampleApp(ExampleStore store) : super(store) {}
}

// **************************************************************************
// AggregateCommandGenerator
// **************************************************************************

abstract class _$CreateExample extends JsonObject {
  _$CreateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static CreateExample fromJson(Object json) => _$CreateExampleFromJson(json);

  @override
  JsonMap toJson() => _$CreateExampleToJson(this as CreateExample);
}

abstract class _$UpdateExample extends JsonObject {
  _$UpdateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static UpdateExample fromJson(Object json) => _$UpdateExampleFromJson(json);

  @override
  JsonMap toJson() => _$UpdateExampleToJson(this as UpdateExample);
}

abstract class _$ImportExample extends JsonObject {
  _$ImportExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static ImportExample fromJson(Object json) => _$ImportExampleFromJson(json);

  @override
  JsonMap toJson() => _$ImportExampleToJson(this as ImportExample);
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _$ExampleCreated extends JsonObject {
  _$ExampleCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<Object, ExampleCreated>(
      _$ExampleCreated.fromJson,
    );
  }

  static ExampleCreated fromJson(Object json) => _$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleCreatedToJson(this as ExampleCreated);
}

abstract class _$ExampleUpdated extends JsonObject {
  _$ExampleUpdated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<Object, ExampleUpdated>(
      _$ExampleUpdated.fromJson,
    );
  }

  static ExampleUpdated fromJson(Object json) => _$ExampleUpdatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleUpdatedToJson(this as ExampleUpdated);
}

abstract class _$ExampleImported extends JsonObject {
  _$ExampleImported(List<Object?> props) : super(props) {
    AggregateEventTypes.define<Object, ExampleImported>(
      _$ExampleImported.fromJson,
    );
  }

  static ExampleImported fromJson(Object json) =>
      _$ExampleImportedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleImportedToJson(this as ExampleImported);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _$ExampleValue extends JsonObject {
  _$ExampleValue(List<Object?> props) : super(props) {
    AggregateValueTypes.define<Object, ExampleValue>(
      _$ExampleValue.fromJson,
    );
  }

  static ExampleValue fromJson([Object? json]) =>
      _$ExampleValueFromJson(json ?? {});

  @override
  JsonMap toJson() => _$ExampleValueToJson(this as ExampleValue);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _$ExampleState extends AggregateState<ExampleValue> {
  _$ExampleState(ExampleValue? value, int? version)
      : super(value ?? ExampleValue(), version) {
    AggregateStateTypes.define<ExampleValue, ExampleState>(
      ([value, version]) => ExampleState(value, version),
    );
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

const ExampleGeneratedCodeInferred = r'''
// **************************************************************************
// AggregateGenerator
// **************************************************************************

typedef ExampleStore = AggregateStore<JsonMap, JsonObject, ExampleValue,
    ExampleId, ExampleState, Example>;

typedef ExampleStateResult
    = AggregateStateResult<JsonObject, ExampleValue, ExampleId, ExampleState>;

typedef ExampleStateOk
    = AggregateStateOk<JsonObject, ExampleValue, ExampleId, ExampleState>;

typedef ExampleStateError
    = AggregateStateError<JsonObject, ExampleValue, ExampleId, ExampleState>;

typedef ExampleStateNoOp
    = AggregateStateNoOp<JsonObject, ExampleValue, ExampleId, ExampleState>;

abstract class _$Example
    extends Aggregate<JsonObject, ExampleValue, ExampleId, ExampleState> {
  _$Example(ExampleId id, ExampleState? state)
      : super(id, state ?? ExampleState()) {
    AggregateTypes.define<JsonObject, ExampleValue, ExampleId, ExampleState,
        Example>(
      (id, [state]) => Example(id, state),
    );
  }
  // ignore: unused_element
  static Example from(String id) => Example(ExampleId(id));

  String get title => current.title;
  String get author => current.author;

  ExampleStateResult createExample(
      {required String title, required String author}) {
    ensureDoesntExists();
    return apply(
        ExampleCreated(exampleId: id.value, title: title, author: author));
  }

  ExampleStateResult updateExample(String title, String? author) {
    ensureExists();
    return apply(ExampleUpdated(id.value, title, author));
  }

  ExampleStateResult importExample(String title, [String? author = 'user']) {
    return apply(ExampleImported(id.value, title, author));
  }
}

// **************************************************************************
// ApplicationGenerator
// **************************************************************************

typedef ExampleResult = AggregateCommandResult<JsonObject, ExampleValue,
    ExampleId, ExampleState, Example>;

typedef ExampleOk = AggregateCommandOkResult<JsonObject, ExampleValue,
    ExampleId, ExampleState, Example>;

typedef ExampleError = AggregateCommandErrorResult<JsonObject, ExampleValue,
    ExampleId, ExampleState, Example>;

abstract class _$ExampleApp extends ApplicationServiceBase<JsonMap, JsonObject,
    ExampleValue, ExampleId, ExampleState, Example> {
  _$ExampleApp(ExampleStore store) : super(store) {
    onNew<CreateExample>(
      (cmd) => ExampleId(cmd.exampleId),
      (cmd, example) =>
          example.createExample(title: cmd.title, author: cmd.author),
    );

    onExisting<UpdateExample>(
      (cmd) => ExampleId(cmd.exampleId),
      (cmd, example) => example.updateExample(cmd.title, cmd.author),
    );

    onAny<ImportExample>(
      (cmd) => ExampleId(cmd.exampleId),
      (cmd, example) => example.importExample(cmd.title, cmd.author),
    );
  }
  FutureOr<ExampleResult> createExample(
      {required String exampleId,
      required String title,
      required String author}) {
    return handle(
        CreateExample(exampleId: exampleId, title: title, author: author));
  }

  FutureOr<ExampleResult> updateExample(
      String exampleId, String title, String? author) {
    return handle(UpdateExample(exampleId, title, author));
  }

  FutureOr<ExampleResult> importExample(String exampleId, String title,
      [String? author = 'user']) {
    return handle(ImportExample(exampleId, title, author));
  }
}

// **************************************************************************
// AggregateCommandGenerator
// **************************************************************************

abstract class _$CreateExample extends JsonObject {
  _$CreateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static CreateExample fromJson(JsonMap json) => _$CreateExampleFromJson(json);

  @override
  JsonMap toJson() => _$CreateExampleToJson(this as CreateExample);
}

abstract class _$UpdateExample extends JsonObject {
  _$UpdateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static UpdateExample fromJson(JsonMap json) => _$UpdateExampleFromJson(json);

  @override
  JsonMap toJson() => _$UpdateExampleToJson(this as UpdateExample);
}

abstract class _$ImportExample extends JsonObject {
  _$ImportExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static ImportExample fromJson(JsonMap json) => _$ImportExampleFromJson(json);

  @override
  JsonMap toJson() => _$ImportExampleToJson(this as ImportExample);
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _$ExampleCreated extends JsonObject {
  _$ExampleCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleCreated>(
      _$ExampleCreated.fromJson,
    );
  }

  static ExampleCreated fromJson(JsonMap json) =>
      _$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleCreatedToJson(this as ExampleCreated);
}

abstract class _$ExampleUpdated extends JsonObject {
  _$ExampleUpdated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleUpdated>(
      _$ExampleUpdated.fromJson,
    );
  }

  static ExampleUpdated fromJson(JsonMap json) =>
      _$ExampleUpdatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleUpdatedToJson(this as ExampleUpdated);
}

abstract class _$ExampleImported extends JsonObject {
  _$ExampleImported(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleImported>(
      _$ExampleImported.fromJson,
    );
  }

  static ExampleImported fromJson(JsonMap json) =>
      _$ExampleImportedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleImportedToJson(this as ExampleImported);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _$ExampleValue extends JsonObject {
  _$ExampleValue(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, ExampleValue>(
      _$ExampleValue.fromJson,
    );
  }

  static ExampleValue fromJson([JsonMap? json]) =>
      _$ExampleValueFromJson(json ?? {});

  @override
  JsonMap toJson() => _$ExampleValueToJson(this as ExampleValue);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _$ExampleState extends AggregateState<ExampleValue> {
  _$ExampleState(ExampleValue? value, int? version)
      : super(value ?? ExampleValue(), version) {
    AggregateStateTypes.define<ExampleValue, ExampleState>(
      ([value, version]) => ExampleState(value, version),
    );
    on<ExampleCreated>(patch);

    on<ExampleUpdated>(patch);

    on<ExampleImported>(patch);
  }

  String get title => value.title;
  String get author => value.author;

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

const ExampleGeneratedCodeTyped = r'''
// **************************************************************************
// AggregateGenerator
// **************************************************************************

typedef ExampleStore = AggregateStore<JsonMap, JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1, Example>;

typedef ExampleState1Result = AggregateStateResult<JsonObject,
    ExampleStateModel1, ExampleId1, ExampleState1>;

typedef ExampleState1Ok = AggregateStateOk<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1>;

typedef ExampleState1Error = AggregateStateError<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1>;

typedef ExampleState1NoOp = AggregateStateNoOp<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1>;

abstract class _$Example extends Aggregate<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1> {
  _$Example(ExampleId1 id, ExampleState1? state)
      : super(id, state ?? ExampleState1()) {
    AggregateTypes.define<JsonObject, ExampleStateModel1, ExampleId1,
        ExampleState1, Example>(
      (id, [state]) => Example(id, state),
    );
  }
  // ignore: unused_element
  static Example from(String id) => Example(ExampleId1(id));

  String get title => current.title;
  String get author => current.author;

  ExampleState1Result createExample(
      {required String title, required String author}) {
    ensureDoesntExists();
    return apply(
        ExampleCreated(exampleId: id.value, title: title, author: author));
  }

  ExampleState1Result updateExample(String title, String? author) {
    ensureExists();
    return apply(ExampleUpdated(id.value, title, author));
  }

  ExampleState1Result importExample(String title, [String? author = 'user']) {
    return apply(ExampleImported(id.value, title, author));
  }
}

// **************************************************************************
// ApplicationGenerator
// **************************************************************************

typedef ExampleResult = AggregateCommandResult<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1, Example>;

typedef ExampleOk = AggregateCommandOkResult<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1, Example>;

typedef ExampleError = AggregateCommandErrorResult<JsonObject,
    ExampleStateModel1, ExampleId1, ExampleState1, Example>;

abstract class _$ExampleApp extends ApplicationServiceBase<JsonMap, JsonObject,
    ExampleStateModel1, ExampleId1, ExampleState1, Example> {
  _$ExampleApp(ExampleStore store) : super(store) {
    onNew<CreateExample>(
      (cmd) => ExampleId1(cmd.exampleId),
      (cmd, example) =>
          example.createExample(title: cmd.title, author: cmd.author),
    );

    onExisting<UpdateExample>(
      (cmd) => ExampleId1(cmd.exampleId),
      (cmd, example) => example.updateExample(cmd.title, cmd.author),
    );

    onAny<ImportExample>(
      (cmd) => ExampleId1(cmd.exampleId),
      (cmd, example) => example.importExample(cmd.title, cmd.author),
    );
  }
  FutureOr<ExampleResult> createExample(
      {required dynamic exampleId,
      required String title,
      required String author}) {
    return handle(
        CreateExample(exampleId: exampleId, title: title, author: author));
  }

  FutureOr<ExampleResult> updateExample(
      String exampleId, String title, String? author) {
    return handle(UpdateExample(exampleId, title, author));
  }

  FutureOr<ExampleResult> importExample(String exampleId, String title,
      [String? author = 'user']) {
    return handle(ImportExample(exampleId, title, author));
  }
}

// **************************************************************************
// AggregateCommandGenerator
// **************************************************************************

abstract class _$CreateExample extends JsonObject {
  _$CreateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static CreateExample fromJson(JsonMap json) => _$CreateExampleFromJson(json);

  @override
  JsonMap toJson() => _$CreateExampleToJson(this as CreateExample);
}

abstract class _$UpdateExample extends JsonObject {
  _$UpdateExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static UpdateExample fromJson(JsonMap json) => _$UpdateExampleFromJson(json);

  @override
  JsonMap toJson() => _$UpdateExampleToJson(this as UpdateExample);
}

abstract class _$ImportExample extends JsonObject {
  _$ImportExample(List<Object?> props) : super(props);

  // ignore: unused_element
  static ImportExample fromJson(JsonMap json) => _$ImportExampleFromJson(json);

  @override
  JsonMap toJson() => _$ImportExampleToJson(this as ImportExample);
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _$ExampleCreated extends JsonObject {
  _$ExampleCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleCreated>(
      _$ExampleCreated.fromJson,
    );
  }

  static ExampleCreated fromJson(JsonMap json) =>
      _$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleCreatedToJson(this as ExampleCreated);
}

abstract class _$ExampleUpdated extends JsonObject {
  _$ExampleUpdated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleUpdated>(
      _$ExampleUpdated.fromJson,
    );
  }

  static ExampleUpdated fromJson(JsonMap json) =>
      _$ExampleUpdatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleUpdatedToJson(this as ExampleUpdated);
}

abstract class _$ExampleImported extends JsonObject {
  _$ExampleImported(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, ExampleImported>(
      _$ExampleImported.fromJson,
    );
  }

  static ExampleImported fromJson(JsonMap json) =>
      _$ExampleImportedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleImportedToJson(this as ExampleImported);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _$ExampleStateModel1 extends JsonObject {
  _$ExampleStateModel1(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, ExampleStateModel1>(
      _$ExampleStateModel1.fromJson,
    );
  }

  static ExampleStateModel1 fromJson([JsonMap? json]) =>
      _$ExampleStateModel1FromJson(json ?? {});

  @override
  JsonMap toJson() => _$ExampleStateModel1ToJson(this as ExampleStateModel1);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _$ExampleState1 extends AggregateState<ExampleStateModel1> {
  _$ExampleState1(ExampleStateModel1? value, int? version)
      : super(value ?? ExampleStateModel1(), version) {
    AggregateStateTypes.define<ExampleStateModel1, ExampleState1>(
      ([value, version]) => ExampleState1(value, version),
    );
    on<ExampleCreated>(patch);

    on<ExampleUpdated>(patch);

    on<ExampleImported>(patch);
  }

  String get title => value.title;
  String get author => value.author;

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
