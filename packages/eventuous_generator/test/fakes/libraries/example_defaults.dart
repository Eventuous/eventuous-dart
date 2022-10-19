import 'package:eventuous/eventuous.dart';
import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.aggregate.dart';

// =============================================================
//
// Example library
//  - without concrete sub-types given
//  - with default naming "Example{{SubType}}"
//
// =============================================================

@GrpcServiceType(Example)
class ExampleGrpcQueryService extends _$ExampleGrpcQueryService {
  ExampleGrpcQueryService(ExampleApp app) : super(app);
}

@GrpcServiceType(Example)
class ExampleGrpcCommandService extends _$ExampleGrpcCommandService {
  ExampleGrpcCommandService(ExampleApp app) : super(app);
}

@ApplicationType(Example)
class ExampleApp extends _$ExampleApp {
  ExampleApp(ExampleStore store) : super(store);
}

@AggregateType()
class Example extends _$Example {
  Example(ExampleId id, [ExampleState? state]) : super(id, state);
}

@AggregateIdType(Example)
class ExampleId extends AggregateId {
  ExampleId([String? id]) : super(id);
}

@JsonSerializable()
@AggregateValueType(Example)
class ExampleValue extends _$ExampleValue {
  ExampleValue(this.title, this.author) : super([title, author]);
  final String title;
  final String author;
}

@AggregateStateType(Example)
class ExampleState extends _$ExampleState {}

@JsonSerializable()
@AggregateCommandType(Example, ExampleCreated,
    expected: ExpectedState.notExists)
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
