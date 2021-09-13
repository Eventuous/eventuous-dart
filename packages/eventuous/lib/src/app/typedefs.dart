import 'dart:async';

import 'package:eventuous/eventuous.dart';

typedef AggregateIdResolver<TState extends Object, TId extends AggregateId>
    = FutureOr<TId> Function(TState command);

typedef AggregateIdMap<TState extends Object, TId extends AggregateId>
    = Map<Type, AggregateIdResolver<TState, TId>>;

typedef AggregateCommandHandler<
        TCommand extends Object,
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    = FutureOr<void> Function(TCommand command, TAggregate aggregate);

typedef AggregateCommandHandlersMap<
        TCommand extends Object,
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    = Map<
        Type,
        RegisteredAggregateCommandHandler<TCommand, TEvent, TValue, TId, TState,
            TAggregate>>;
