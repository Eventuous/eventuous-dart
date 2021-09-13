import 'package:eventuous/eventuous.dart';
import 'package:eventuous_annotation/eventuous_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';
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

@AggregateValueType(Example, data: JsonMap)
class ExampleStateModel1 extends _$ExampleStateModel1 {
  ExampleStateModel1() : super([]);

  @override
  JsonMap toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

@AggregateStateType(Example, value: ExampleStateModel1)
class ExampleState1 extends _$ExampleState1 {
  ExampleState1([ExampleStateModel1? value, int? version])
      : super(value, version);
}

@JsonSerializable()
@AggregateEventType(Example)
class ExampleCreated extends _$ExampleCreated {
  ExampleCreated() : super([]);
}
