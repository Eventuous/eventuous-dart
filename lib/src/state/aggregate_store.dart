part of 'aggregate.dart';

/// [AggregateStore] store maintains [Aggregate] instances.
///
/// This decouples loading [AggregateState] from [Aggregate] allowing
/// different strategies to be implemented like building state
/// directly from the [StreamEventStore] by folding every event on
/// some initial condition, or loading state from a snapshot of last
/// stored [AggregateState].
///
/// This class implements [AggregateCreator] as default method.
///
/// * Type parameter [TData] - [StreamEvent.data] content type
/// * Type parameter [TEvent] - [Aggregate.changes] event type
/// * Type parameter [TValue] - [AggregateState.value] type
/// * Type parameter [TId] - [Aggregate.id] type
/// * Type parameter [TState] - [AggregateState] type
/// * Type parameter [TAggregate] - [Aggregate] type
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
  /// If [states] is not given, [AggregateStateCreator]
  /// must be registered with [AggregateStateType.addType],
  /// or method [newStateInstance] must be overridden.
  ///
  @mustCallSuper
  AggregateStore(
    StreamEventStore events, {
    EventSerializer<TEvent>? serializer,
    AggregateCreator<TEvent, TValue, TId, TState, TAggregate>? onNew,
    AggregateStateStorage<TValue, TState>? states,
  })  : _onNew = onNew,
        _events = events,
        _states = states,
        _serializer = serializer ?? DefaultEventSerializer<TData, TEvent>() {
    //
    // Sanity checks
    //
    if (_onNew == null && !AggregateType.containsType(TAggregate)) {
      throw UnimplementedError('newInstance is not implemented');
    }
    if (_states == null && !AggregateStateType.containsType(TState)) {
      throw UnimplementedError('newStateInstance is not implemented');
    }
  }

  /// [AggregateCreator] instance. If not
  /// given, method [newInstance] must be overridden.
  final AggregateCreator<TEvent, TValue, TId, TState, TAggregate>? _onNew;

  /// [StreamEventStore] loading and storing [StreamEvent]s
  StreamEventStore get events => _events;
  final StreamEventStore _events;

  /// [AggregateStateStore] loading [AggregateState]s
  AggregateStateStorage<TValue, TState>? get states => _states;
  final AggregateStateStorage<TValue, TState>? _states;

  /// [EventSerializer] for serializing and deserializing [Event]s
  late final EventSerializer<TEvent> _serializer;

  /// Create new [Aggregate] instance of type [TAggregate]
  TAggregate newInstance(TId id, [TState? state]) {
    return _onNew == null
        ? AggregateType.create<TEvent, TValue, TId, TState, TAggregate>(
            id, state)
        : _onNew!(id, state);
  }

  /// Create new [AggregateState] instance of type [TState]
  TState newStateInstance([TValue? value]) {
    return _states == null
        ? AggregateStateType.create<TValue, TState>(value)
        : _states!.newInstance(value);
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
    final next = StreamReadPosition(aggregate.originalVersion + 1);
    try {
      for (var event in await _events.readEvents(stream, next)) {
        aggregate.fold(_toDomainEvent(event));
      }
      return aggregate;
    } on StreamNotFoundException catch (e) {
      throw AggregateNotFoundException(TAggregate, id, e);
    }
  }

  /// Load state for [Aggregate] with given [id].
  FutureOr<TState> loadState(TId id, [TValue? value]) async {
    return _states == null
        ? newStateInstance(value)
        : await _states!.load(StreamName.fromId(TAggregate, id));
  }

  TEvent _toDomainEvent(StreamEvent event) {
    return _serializer.decode(
      event.data,
      event.eventType,
    );
  }

  /// Save [AggregateState] of given [aggregate]
  Future<AggregateStateResult<TEvent, TValue, TId, TState>> delete(
      TAggregate aggregate) async {
    try {
      aggregate.ensureExists();
      await _events.deleteStream(
        StreamName.from(aggregate),
        aggregate.expectedVersion,
      );
      return AggregateStateResult.ok(
        current: aggregate.current,
        previous: aggregate.original,
      );
    } on StreamNotFoundException {
      return AggregateStateResult.error(
        AggregateNotFoundException(
          TAggregate,
          aggregate.id,
        ),
        aggregate,
      );
    } on Exception catch (error) {
      return AggregateStateResult.error(
        error,
        aggregate..rollback(),
      );
    }
  }

  /// Truncate [AggregateState] of given [aggregate]
  Future<AggregateStateResult<TEvent, TValue, TId, TState>> truncate(
      TAggregate aggregate) async {
    try {
      aggregate.ensureExists();
      await _events.truncateStream(
        StreamName.from(aggregate),
        aggregate.expectedVersion,
        aggregate.expectedVersion.toTruncatePosition(
          StreamTruncatePosition.Exclude,
        ),
      );
      return AggregateStateResult.ok(
        current: aggregate.current,
        previous: aggregate.original,
      );
    } on StreamNotFoundException {
      return AggregateStateResult.error(
        AggregateNotFoundException(
          TAggregate,
          aggregate.id,
        ),
        aggregate,
      );
    } on Exception catch (error) {
      return AggregateStateResult.error(
        error,
        aggregate..rollback(),
      );
    }
  }

  /// Save [AggregateState] of given [aggregate] to this store
  Future<AggregateStateResult<TEvent, TValue, TId, TState>> save(
      TAggregate aggregate) async {
    if (!aggregate.isChanged) {
      return AggregateStateNoOp(aggregate.current);
    }

    try {
      var position = aggregate.expectedVersion.value;
      final append = await _events.appendEvents(
        StreamName.from(aggregate),
        aggregate.changes.map(
          (e) => toStreamEvent(e, ++position),
        ),
        aggregate.expectedVersion,
      );
      if (append.isOk) {
        final result = aggregate.commit();
        await _saveState(aggregate);
        return result;
      }
      return AggregateStateResult.error(
        (append as AppendEventsError).cause,
        aggregate,
      );
    } on StreamNotFoundException {
      return AggregateStateResult.error(
        AggregateNotFoundException(
          TAggregate,
          aggregate.id,
        ),
        aggregate,
      );
    } on Exception catch (error) {
      return AggregateStateResult.error(
        error,
        aggregate..rollback(),
      );
    }
  }

  // Save state of given [aggregate]
  FutureOr<TAggregate> _saveState(TAggregate aggregate) async {
    if (_states != null) {
      await _states!.save(
        StreamName.fromId(TAggregate, aggregate.id),
        aggregate.current,
      );
    }
    return aggregate;
  }

  StreamEvent toStreamEvent(TEvent event, int position) {
    return StreamEvent(
      EventType.getTypeNameFromEvent(event),
      _serializer.encode(event),
      _serializer.contentType,
      position,
    );
  }
}
