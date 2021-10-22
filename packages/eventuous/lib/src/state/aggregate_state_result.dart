part of 'aggregate.dart';

abstract class AggregateStateResult<
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>> {
  AggregateStateResult(
    this.previous,
    this.current,
  ) : version = (current ?? previous).version;

  factory AggregateStateResult.ok({
    required TState current,
    required TState previous,
  }) =>
      previous == current
          ? AggregateStateNoOp<TEvent, TValue, TId, TState>(current)
          : AggregateStateOk<TEvent, TValue, TId, TState>(
              current: current,
              previous: previous,
            );

  factory AggregateStateResult.error(
    Object failure,
    Aggregate<TEvent, TValue, TId, TState> aggregate,
  ) =>
      AggregateStateError(
        failure,
        current: aggregate.current,
        previous: aggregate.original,
      );

  /// Current version
  final int version;

  /// Previous [AggregateState] value
  final TState previous;

  /// Current [AggregateState] value
  final TState? current;

  /// Check if state is OK
  bool get isOk => this is AggregateStateOk<TEvent, TValue, TId, TState>;

  /// Check if no state change occurred
  bool get isNoOp => this is AggregateStateNoOp<TEvent, TValue, TId, TState>;

  /// Check if error state
  bool get isError => this is AggregateStateError<TEvent, TValue, TId, TState>;

  @override
  String toString() {
    return '$runtimeType{version: $version, previous: $previous, current: $current}';
  }
}

class AggregateStateOk<TEvent extends Object, TValue extends Object,
        TId extends AggregateId, TState extends AggregateState<TValue>>
    extends AggregateStateResult<TEvent, TValue, TId, TState> {
  AggregateStateOk({
    required TState previous,
    required TState current,
  }) : super(previous, current);
}

class AggregateStateNoOp<TEvent extends Object, TValue extends Object,
        TId extends AggregateId, TState extends AggregateState<TValue>>
    extends AggregateStateResult<TEvent, TValue, TId, TState> {
  AggregateStateNoOp(
    TState state,
  ) : super(state, state);
}

class AggregateStateError<TEvent extends Object, TValue extends Object,
        TId extends AggregateId, TState extends AggregateState<TValue>>
    extends AggregateStateResult<TEvent, TValue, TId, TState> {
  AggregateStateError(
    this.cause, {
    required TState previous,
    required TState current,
  }) : super(previous, current);

  final Object cause;

  @override
  String toString() {
    return '$runtimeType{version: $version, previous: $previous, current: $current, cause: $cause}';
  }
}
