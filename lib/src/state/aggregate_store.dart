part of 'aggregate.dart';

/// [AggregateStore] store loads [AggregateState] from [AggregateStateStore].
///
/// This decouples loading [AggregateState] from [Aggregate] allowing
/// different strategies to be implemented like building state
/// directly from the [EventStore] by folding every event on some
/// initial condition, or loading state from a locally persisted
/// snapshot of last stored [AggregateState].
///
/// This class implements [AggregateCreator] as default method.

/// Type parameter [TData] - [StreamEvent.data] content type
/// Type parameter [TEvent] - [Aggregate.changes] event type
/// Type parameter [TValue] - [AggregateState.value] type
/// Type parameter [TId] - [Aggregate.id] type
/// Type parameter [TState] - [AggregateState] type
/// Type parameter [TAggregate] - [Aggregate] type
///
class AggregateStore<
    TData extends Object,
    TEvent extends Object,
    TValue extends Object,
    TId extends AggregateId,
    TState extends AggregateState<TValue>,
    TAggregate extends Aggregate<TEvent, TValue, TId, TState>> {
  /// Default constructor.
  ///
  /// If [onNew] is not given, [AggregateCreator]
  /// must be registered with [AggregateType.addType],
  /// or method [newInstance] must be overridden.
  ///
  /// If [stateStore] is not given, [AggregateStateCreator]
  /// must be registered with [AggregateStateType.addType],
  /// or method [newStateInstance] must be overridden.
  ///
  @mustCallSuper
  AggregateStore(
    EventStore eventStore, {
    EventSerializer<TEvent>? serializer,
    AggregateCreator<TEvent, TValue, TId, TState, TAggregate>? onNew,
    AggregateStateStore<TValue, TState>? stateStore,
  })  : _onNew = onNew,
        _eventStore = eventStore,
        _stateStore = stateStore,
        _serializer = serializer ?? DefaultEventSerializer<TData, TEvent>() {
    //
    // Sanity checks
    //
    if (_onNew == null && !AggregateType.containsType(TAggregate)) {
      throw UnimplementedError('newInstance is not implemented');
    }
    if (_stateStore == null && !AggregateStateType.containsType(TState)) {
      throw UnimplementedError('newStateInstance is not implemented');
    }
  }

  /// [AggregateCreator] instance. If not
  /// given, method [newInstance] must be overridden.
  final AggregateCreator<TEvent, TValue, TId, TState, TAggregate>? _onNew;

  /// [EventStore] loading and storing [StreamEvent]s
  final EventStore _eventStore;

  /// [AggregateStateStore] loading [AggregateState]s
  final AggregateStateStore<TValue, TState>? _stateStore;

  /// [EventSerializer] for serializing and deserializing [Event]s
  late final EventSerializer<TEvent> _serializer;

  /// [AggregateCreator] implementation. If [state] is not given,
  /// a new [AggregateState] instance will be created from [EventStore].
  TAggregate call(TId id, [TState? state]) => newInstance(id, state);

  /// Create new [Aggregate] instance of type [TAggregate]
  TAggregate newInstance(TId id, [TState? state]) {
    return _onNew == null
        ? AggregateType.create<TEvent, TValue, TId, TState, TAggregate>(
            id, state)
        : _onNew!(id, state);
  }

  /// Create new [AggregateState] instance of type [TState]
  TState newStateInstance([TValue? value]) {
    return _stateStore == null
        ? AggregateStateType.create<TValue, TState>(value)
        : _stateStore!.newInstance(value);
  }

  /// Load [AggregateState] into given [aggregate] from this store
  /// If aggregate does not exist a AggregateNotFound is thrown.
  @mustCallSuper
  Future<TAggregate> load(TId id) async {
    final aggregate = newInstance(
      id,
      await loadState(id),
    );
    final stream = StreamName.fromId(TAggregate, id);
    final start = StreamReadPosition(aggregate.originalVersion);
    try {
      await _eventStore
          .readStream(stream, start)
          .map(_toDomainEvent)
          .map((event) => aggregate.fold(event))
          .length;
      return aggregate;
    } on StreamNotFoundException catch (e) {
      throw AggregateNotFoundException(TAggregate, id, e);
    }
  }

  /// Load state for [Aggregate] with given [id].
  FutureOr<TState> loadState(TId id, [TValue? value]) async {
    return _stateStore == null
        ? newStateInstance(value)
        : await _stateStore!.load(StreamName.fromId(TAggregate, id));
  }

  TEvent _toDomainEvent(StreamEvent event) {
    return _serializer.decode(
      event.data,
      event.name,
    );
  }

  /// Save [AggregateState] of given [aggregate] to this store
  ///
  Future<AggregateStateResult<TEvent, TValue, TId, TState>> save(
      TAggregate aggregate) async {
    if (!aggregate.isChanged) {
      return AggregateStateNoOp(aggregate.current);
    }

    try {
      await _eventStore.appendEvents(
        StreamName.from(aggregate),
        aggregate.changes.map(toStreamEvent),
        aggregate.expectedVersion,
      );
      final result = aggregate.commit();
      await _saveState(aggregate);
      return result;
    } on StreamNotFoundException {
      return AggregateStateResult.fromCause(
        AggregateNotFoundException(
          TAggregate,
          aggregate.id,
        ),
        aggregate,
      );
    } on Exception catch (error) {
      return AggregateStateResult.fromCause(
        error,
        aggregate..rollback(),
      );
    }
  }

  // Save state of given [aggregate]
  FutureOr<TAggregate> _saveState(TAggregate aggregate) async {
    if (_stateStore != null) {
      await _stateStore!.save(
        StreamName.fromId(TAggregate, aggregate.id),
        aggregate.current,
      );
    }
    return aggregate;
  }

  StreamEvent toStreamEvent(TEvent event) {
    return StreamEvent(
      EventType.getTypeNameFromEvent(event),
      _serializer.encode(event),
      _serializer.contentType,
    );
  }
}
