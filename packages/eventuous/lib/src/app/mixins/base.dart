part of '../service.dart';

/// Application service base mixin.

/// * Type parameter [TData] - [StreamEvent.data] content type
/// * Type parameter [TEvent] - [Aggregate.changes] event type
/// * Type parameter [TValue] - [AggregateState.value] type
/// * Type parameter [TId] - [Aggregate.id] type
/// * Type parameter [TState] - [AggregateState] type
/// * Type parameter [TAggregate] - [Aggregate] type
///
mixin ApplicationServiceMixin<
    TData extends Object,
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>,
    TAggregate extends Aggregate<TEvent, TValue, TId, TState>> {
  /// Get [AggregateStore] which this service operate on
  AggregateStore<TData, TEvent, TValue, TId, TState, TAggregate> get store;

  // Internal map of command handlers
  final AggregateCommandHandlersMap<Object, TEvent, TValue, TId, TState,
      TAggregate> _handlers = {};

  // Internal map of aggregate id resolvers
  final AggregateIdMap<Object, TId> _resolvers = {};

  /// The generic command handler. Call this function from your edge (API).
  /// Use parameter [command] to execute
  /// Returns the [AggregateCommandResult] of the execution
  /// * Type parameter [TCommand] - command type
  FutureOr<AggregateCommandResult<TEvent, TValue, TId, TState, TAggregate>>
      handle<TCommand extends Object>(
    TCommand command,
  ) async {
    TAggregate? aggregate;
    final handler = _handlers[typeOf<TCommand>()];
    if (handler == null) {
      throw CommandHandlerNotFoundException(typeOf<TCommand>());
    }
    try {
      switch (handler.expected) {
        case ExpectedState.notExists:
          aggregate = await _create<TCommand>(command);
          break;
        case ExpectedState.exists:
          aggregate = await _load<TCommand>(command);
          break;
        case ExpectedState.any:
          aggregate = await _tryLoad<TCommand>(command);
          break;
        default:
          return _toError(ArgumentError.value(
            handler.expected,
            '$handler',
            'Unknown expected state',
          ));
      }
      await _handlers[typeOf<TCommand>()]!(
        command,
        aggregate,
      );
      return aggregate.isChanged
          ? _fromResult(
              aggregate,
              await store.save(aggregate),
            )
          : _toOk(aggregate);
    } on Exception catch (error) {
      return _toError(
        error,
        aggregate,
      );
    }
  }

  AggregateCommandResult<TEvent, TValue, TId, TState, TAggregate> _fromResult(
    TAggregate aggregate,
    AggregateStateResult<TEvent, TValue, TId, TState> result,
  ) {
    return result.isError
        ? _toError(
            (result as AggregateStateError<TEvent, TValue, TId, TState>).cause,
            aggregate,
          )
        : _toOk(aggregate);
  }

  AggregateCommandOkResult<TEvent, TValue, TId, TState, TAggregate> _toOk(
      TAggregate aggregate) {
    return AggregateCommandOkResult<TEvent, TValue, TId, TState, TAggregate>(
      aggregate,
      StreamReadPosition(aggregate.currentVersion),
    );
  }

  AggregateCommandErrorResult<TEvent, TValue, TId, TState, TAggregate> _toError(
    Object cause, [
    TAggregate? aggregate,
  ]) {
    return AggregateCommandErrorResult<TEvent, TValue, TId, TState, TAggregate>(
      cause,
      aggregate,
    );
  }

  Future<TAggregate> _tryLoad<TCommand extends Object>(TCommand command) async {
    try {
      return await _load<TCommand>(command);
    } on AggregateNotFoundException {
      return _create<TCommand>(command);
    }
  }

  Future<TAggregate> _load<TCommand extends Object>(TCommand command) async {
    final id = await _resolvers[typeOf<TCommand>()]!(command);
    return store.load(id);
  }

  Future<TAggregate> _create<TCommand extends Object>(TCommand command) async {
    final id = await _resolvers[typeOf<TCommand>()]!(command);
    return store.newInstance(id);
  }
}
