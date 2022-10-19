import 'package:eventuous/eventuous.dart';
import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.aggregate.dart';

@GrpcServiceType(Example)
class ExampleGrpcQueryService extends _$ExampleGrpcQueryService {
  ExampleGrpcQueryService(ExampleApp app) : super(app);
}

@GrpcServiceType(Example)
class ExampleGrpcCommandService extends _$ExampleGrpcCommandService {
  ExampleGrpcCommandService(ExampleApp app) : super(app);
}

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

@AggregateIdType(Example)
class ExampleId1 extends AggregateId {
  ExampleId1(String id) : super(id);
}

@JsonSerializable()
@AggregateValueType(Example, data: JsonMap)
class ExampleStateModel1 extends _$ExampleStateModel1 {
  ExampleStateModel1(this.title, this.author) : super([title, author]);
  final String title;
  final String author;
}

@AggregateStateType(Example)
class ExampleState1 extends _$ExampleState1 {
  ExampleState1([ExampleStateModel1? value, int? version])
      : super(value, version);
}

@JsonSerializable()
@AggregateCommandType(Example, ExampleCreated,
    expected: ExpectedState.notExists)
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
