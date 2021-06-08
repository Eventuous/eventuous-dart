import 'package:eventuate/eventuate.dart';

typedef JsonMap = Map<String, dynamic>;

class FooId extends AggregateId {
  FooId([String? id]) : super(id);
}

class Foo extends Aggregate<JsonMap> {
  Foo([
    String? id,
    FooState? state,
  ]) : super(FooId(id), state ?? FooState());

  static Foo from(String id) => Foo(id);
}

class FooState extends AggregateState<JsonMap> {
  FooState([
    JsonMap? value,
  ]) : super(value ?? <String, dynamic>{}) {
    on<FooCreated>((event, _) => FooState(event.data));
    on<FooUpdated>((event, _) => FooState(event.data));
  }
}

class FooCreated extends DomainEvent<JsonMap> {
  FooCreated(JsonMap data) : super(data);
}

class FooUpdated extends DomainEvent<JsonMap> {
  FooUpdated(JsonMap data) : super(data);
}

void addFooTypes() {
  AggregateTypeMap.addType<JsonMap, Foo>(
    (id, [state]) => Foo(id, state as FooState),
  );
  AggregateStateTypeMap.addType<JsonMap, FooState>(
    ([value]) => FooState(value),
  );
  addFooEventTypes();
}

void addFooEventTypes() {
  DomainEventTypeMap.addType<FooCreated>((data) => FooCreated(data));
  DomainEventTypeMap.addType<FooUpdated>((data) => FooUpdated(data));
}
