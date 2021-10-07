import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foo.g.dart';

@AggregateType(
  id: FooId1,
  event: JsonObject,
  state: FooState1,
  value: FooStateModel1,
)
class Foo extends _$Foo {
  Foo(FooId1 id, [FooState1? state]) : super(id, state);
}

class FooId1 extends AggregateId {
  FooId1(String id) : super(id);
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
@AggregateCommandType(Foo)
class CreateFoo extends _$CreateFoo {
  CreateFoo(this.title, this.author) : super([title, author]);
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateEventType(Foo, data: JsonMap)
class FooCreated extends _$FooCreated {
  FooCreated(this.title, this.author) : super([title, author]);
  final String title;
  final String author;
}
