part of 'aggregate_state.dart';

abstract class AggregateStateResult<T> {
  AggregateStateResult(
    AggregateState<T> previous,
    AggregateState<T> current,
  )   : previous = previous.value,
        version = current.version,
        current = current.value;

  factory AggregateStateResult.from({
    required AggregateState<T> current,
    required AggregateState<T> previous,
  }) =>
      previous == current
          ? AggregateStateNoOp(current)
          : AggregateStateOk(
              current: current,
              previous: previous,
            );

  factory AggregateStateResult.failure(
    Object failure,
    Aggregate<T> aggregate,
  ) =>
      AggregateStateFailure(
        failure,
        current: aggregate.current,
        previous: aggregate.original,
      );

  /// Current version
  final int version;

  /// Previous [AggregateState] value
  final T previous;

  /// Current [AggregateState] value
  final T? current;

  /// Check if no operation occurred
  bool get isNoOp => previous != current;
}

class AggregateStateOk<T> extends AggregateStateResult<T> {
  AggregateStateOk({
    required AggregateState<T> previous,
    required AggregateState<T> current,
  }) : super(previous, current);
}

class AggregateStateNoOp<T> extends AggregateStateResult<T> {
  AggregateStateNoOp(
    AggregateState<T> state,
  ) : super(state, state);
}

class AggregateStateFailure<T> extends AggregateStateResult<T> {
  AggregateStateFailure(
    this.failure, {
    required AggregateState<T> previous,
    required AggregateState<T> current,
  }) : super(previous, current);

  final Object failure;
}
