import 'package:eventuous/eventuous.dart';

import '../json/json_typedefs.dart';

/// Use [AggregateType] to define aggregates
///
/// Optional [AggregateType] fields for [parameterized types](https://dart.dev/guides/language/language-tour#restricting-the-parameterized-type)
/// when not given are inferred by introspection or restricted to default [Type]s.
/// If [Eventuous.inferTypes] is true (default) parameterized types are inferred
/// by introspection of annotations associated with [AggregateType]. If introspection
/// fails or [Eventuous.inferTypes] is false, parameterized types are given by
/// (default) naming convention where applicable, or restricted to a default
/// [Type] otherwise.
///
/// Following rules apply when fields in [AggregateType] for
/// parameterized types are not given:
///
/// * [AggregateType.id] (parameterized type [TId]) - inferred from name of class
/// annotated with [AggregateIdType] and associated with [AggregateType].
/// If introspection fails (no association found) or [Eventuous.inferTypes] is
/// false, [TId] is given by name of class annotated with
/// [AggregateType] (default naming convention is "${aggregate}Id").
/// ```dart
/// @AggregateType()
/// class Foo extends _$Foo
/// @AggregateType(Foo) // => infers TId is FooId1
/// class FooId1 extends AggregateId;
/// ```
///
/// * [AggregateType.data] (parameterized type [TData]) - used in
/// [AggregateEventCreator] to create [TEvent]s from [TData]. Inferred from
/// classes annotated with [AggregateEventType]s and associated with
/// [AggregateType]. If introspection fails (no associations found or type
/// can not be derived from them) or [Eventuous.inferTypes] is false,
/// [TData] is restricted to type [JsonMap].
/// ```dart
/// @AggregateType()
/// class Foo extends _$Foo {}
/// @JsonSerializable() // => infers TData is JsonMap
/// @AggregateEventType(Foo) // => links FooCreated with Foo
/// class FooCreated extends _$FooCreated {}
/// ```
///
/// * [AggregateType.event] (parameterized type [TEvent]) - used in
/// [AggregateEventCreator] to create [TEvent]s from [TData]. Inferred from
/// classes annotated with [AggregateEventType]s and associated with
/// [AggregateType]. If introspection fails (no associations found or type
/// can not be derived from them) or [Eventuous.inferTypes] is false,
/// [TEvent] is restricted to type [JsonObject].
/// ```dart
/// @AggregateType()
/// class Foo extends _$Foo {}
/// @JsonSerializable() // => TEvent is JsonObject
/// @AggregateEventType(Foo) // => links FooCreated with Foo
/// class FooCreated extends _$FooCreated {}
/// ```
///
/// * [AggregateType.value] (parameterized type [TValue]) - inferred from name of
/// class annotated with [AggregateValueType]s and associated with [AggregateType].
/// If introspection fails (no associations found) or [Eventuous.inferTypes]
/// is false, [TValue] is given by name of class annotated with
/// [AggregateType] (default naming convention is "${aggregate}Value").
/// ```dart
/// @AggregateType()
/// class Foo extends _$Foo {}
/// @JsonSerializable() // => infers TValue is JsonObject
/// @AggregateValueType(Foo) // => infers TValue is FooValue1
/// class FooValue1 _$FooState {}
/// ```
///
/// * [AggregateType.state] (parameterized type [TState]) - inferred from name of
/// class annotated with [AggregateStateType]s and associated with [AggregateType].
/// If introspection fails (no associations found) or [Eventuous.inferTypes]
/// is false, [TState] is given by name of class annotated with
/// [AggregateType] (default naming convention is "${aggregate}State").
/// ```dart
/// @AggregateType()
/// class Foo extends _$Foo {}
/// @AggregateStateType(Foo) // => infers TState is FooState1
/// class FooState1 _$FooState {}
/// ```
///
class AggregateType {
  const AggregateType({
    this.id,
    this.event,
    this.value,
    this.state,
  });

  final Type? id;
  final Type? event;
  final Type? value;
  final Type? state;

  JsonMap toJson(String aggregate) => {
        'aggregate': aggregate,
        'annotation': '$AggregateType',
        'id': id?.toString(),
        'event': event?.toString(),
        'value': value?.toString(),
        'state': state?.toString(),
      };
}
