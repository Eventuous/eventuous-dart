import 'package:eventuous/eventuous.dart';

abstract class Result<
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>,
    TAggregate extends Aggregate<TEvent, TValue, TId, TState>> {
  Result([this.aggregate]);

  /// [TAggregate] modified
  final TAggregate? aggregate;

  /// Get [TEvent]s appended to [aggregate]
  Iterable<TEvent>? get changes => aggregate?.changes;

  /// Get state after [changes] was applied
  TState? get current => aggregate?.current;

  /// Get state before [changes] was applied
  TState? get original => aggregate?.original;

  bool get isError => !isOk;
  bool get isOk => this is OkResult;
  bool get isNoOp => changes?.isNotEmpty != true;

  @override
  String toString() {
    return '$runtimeType{state: $current, changes: $changes}';
  }
}

class OkResult<
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    extends Result<TEvent, TValue, TId, TState, TAggregate> {
  OkResult(
    TAggregate aggregate,
    this.position,
  ) : super(aggregate);

  final StreamReadPosition position;

  @override
  TState get current => super.current as TState;

  @override
  String toString() {
    return '$runtimeType{state: $current, changes: $changes, position: $position}';
  }
}

class ErrorResult<
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    extends Result<TEvent, TValue, TId, TState, TAggregate> {
  ErrorResult(
    this.cause, [
    TAggregate? aggregate,
  ]) : super(aggregate);

  final Object cause;

  @override
  String toString() {
    return '$runtimeType{cause: $cause, state: $current, changes: $changes}';
  }
}
