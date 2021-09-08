import 'dart:async';

import 'package:eventuous/eventuous.dart';

class RegisteredHandler<
    TCommand extends Object,
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>,
    TAggregate extends Aggregate<TEvent, TValue, TId, TState>> {
  RegisteredHandler(this.expected, this.handler);
  final ExpectedState expected;
  final Handler<TCommand, TEvent, TValue, TId, TState, TAggregate> handler;

  FutureOr<void> call(TCommand command, TAggregate aggregate) =>
      handler(command, aggregate);
}
