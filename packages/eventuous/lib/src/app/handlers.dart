import 'dart:async';

import 'package:eventuous/eventuous.dart';

class RegisteredAggregateCommandHandler<
    TCommand extends Object,
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>,
    TAggregate extends Aggregate<TEvent, TValue, TId, TState>> {
  RegisteredAggregateCommandHandler(this.expected, this.handler);

  final ExpectedState expected;
  final AggregateCommandHandler<TCommand, TEvent, TValue, TId, TState,
      TAggregate> handler;

  FutureOr<void> call(TCommand command, TAggregate aggregate) =>
      handler(command, aggregate);
}
