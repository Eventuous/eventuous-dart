import 'package:eventuous/eventuous.dart';

abstract class Result<
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>,
    TAggregate extends Aggregate<TEvent, TValue, TId, TState>> {
  Result([this.state, this.changes]);
  final TState? state;
  final Iterable<TEvent>? changes;

  bool get isError => !isOK;
  bool get isOK => this is OkResult;
  bool get isNoOp => changes?.isNotEmpty != true;
}

class OkResult<
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    extends Result<TEvent, TValue, TId, TState, TAggregate> {
  OkResult(
    TState state,
    Iterable<TEvent> changes,
    this.position,
  ) : super(state, changes);

  final StreamReadPosition position;

  @override
  TState get state => super.state as TState;
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
    TState? state,
    Iterable<TEvent>? changes,
  ]) : super(state, changes);

  final Object cause;
}
