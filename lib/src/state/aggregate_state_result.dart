part of 'aggregate_state.dart';

abstract class AggregateStateResult<
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>> {
  AggregateStateResult(
    TState previous,
    TState current,
  )   : previous = previous,
        current = current,
        version = current.version;

  factory AggregateStateResult.fromDiff({
    required TState current,
    required TState previous,
  }) =>
      previous == current
          ? AggregateStateNoOp<TEvent, TValue, TId, TState>(current)
          : AggregateStateOk<TEvent, TValue, TId, TState>(
              current: current,
              previous: previous,
            );

  factory AggregateStateResult.fromCause(
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

  /// Check if no operation occurred
  bool get isNoOp => previous.value != current?.value;

  /// Check if state is OK
  bool get isOK => this is AggregateStateOk<TEvent, TValue, TId, TState>;

  /// Check if error state
  bool get isError => this is AggregateStateError<TEvent, TValue, TId, TState>;
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
}
