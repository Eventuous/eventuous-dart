part of '../service.dart';

mixin OnUpdateAggregateMixin<
        TData extends Object,
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    on ApplicationServiceMixin<TData, TEvent, TValue, TId, TState, TAggregate> {
  /// Register an asynchronous handler for a command, which is expected
  /// to use an existing aggregate instance.
  /// Use parameter [toId] to get the [AggregateId] from give command.
  /// Use parameter [action] to performed actions on the aggregate,
  /// given the aggregate instance and the command
  /// * Type parameter [TCommand] - Command type
  void onExisting<TCommand extends Object>(
      AggregateIdResolver<TCommand, TId> toId,
      AggregateCommandHandler<TCommand, TEvent, TValue, TId, TState, TAggregate>
          action) {
    assert(!isFrozen, 'Aggregate handlers has been frozen');

    _handlers.putIfAbsent(
      typeOf<TCommand>(),
      () => RegisteredAggregateCommandHandler<TCommand, TEvent, TValue, TId,
          TState, TAggregate>(
        ExpectedState.exists,
        action,
      ),
    );

    _resolvers.putIfAbsent(
      typeOf<TCommand>(),
      () => (command) => toId(command as TCommand),
    );
  }
}
