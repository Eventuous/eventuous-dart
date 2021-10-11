import 'dart:async';

import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foo.g.dart';

@ApplicationType(Foo)
class FooApp extends _$FooApp {
  FooApp(FooStore store) : super(store);
}

@AggregateType(
  id: FooId,
  event: JsonObject,
  state: FooState1,
  value: FooStateModel1,
)
class Foo extends _$Foo {
  Foo(FooId id, [FooState1? state]) : super(id, state);
}

class FooId extends AggregateId {
  FooId(String id) : super(id);
}

@JsonSerializable()
@AggregateValueType(Foo, data: JsonMap)
class FooStateModel1 extends _$FooStateModel1 {
  FooStateModel1({
    this.title,
    this.author,
  }) : super([title, author]);
  final String? title;
  final String? author;
}

@AggregateStateType(Foo, value: FooStateModel1)
class FooState1 extends _$FooState1 {
  FooState1([FooStateModel1? value, int? version]) : super(value, version);
}

@JsonSerializable()
@AggregateCommandType(Foo, FooCreated, expected: ExpectedState.notExists)
class CreateFoo extends _$CreateFoo {
  CreateFoo({
    required this.fooId,
    required this.title,
    required this.author,
  }) : super([fooId, title, author]);
  final String fooId;
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateCommandType(Foo, FooUpdated, expected: ExpectedState.exists)
class UpdateFoo extends _$UpdateFoo {
  UpdateFoo(this.fooId, this.title, this.author)
      : super([fooId, title, author]);
  final String fooId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateCommandType(Foo, FooImported)
class ImportFoo extends _$ImportFoo {
  ImportFoo(this.fooId, this.title, [this.author = 'user'])
      : super([fooId, title, author]);
  final String fooId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateEventType(Foo, data: JsonMap)
class FooCreated extends _$FooCreated {
  FooCreated({
    required this.fooId,
    required this.title,
    required this.author,
  }) : super([fooId, title, author]);
  final String fooId;
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateEventType(Foo, data: JsonMap)
class FooUpdated extends _$FooUpdated {
  FooUpdated(this.fooId, this.title, this.author)
      : super([fooId, title, author]);
  final String fooId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateEventType(Foo, data: JsonMap)
class FooImported extends _$FooImported {
  FooImported(this.fooId, this.title, [this.author])
      : super([fooId, title, author]);
  final String fooId;
  final String title;
  final String? author;
}
