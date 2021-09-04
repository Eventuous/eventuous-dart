import 'dart:async';

import 'package:eventuate/eventuate.dart';
import 'package:meta/meta.dart';

/// [AggregateStore] store loads [AggregateState] from [AggregateStateStore].
///
/// This decouples loading [AggregateState] from [Aggregate] allowing
/// different strategies to be implemented like building state
/// directly from the [EventStore] by folding every event on some
/// initial condition, or loading state from a locally persisted
/// snapshot of last stored [AggregateState].
///
/// This class implements [AggregateCreator] as default method.
///
/// Type parameter [V] - [AggregateState.value] type
/// Type parameter [S] - [AggregateState] type
/// Type parameter [T] - [Aggregate] type
///
class AggregateStore<V, S extends AggregateState<V>, T extends Aggregate<V>> {
  /// Default constructor.
  ///
  /// If [onNew] is not given, [AggregateCreator]
  /// must be registered with [AggregateTypeMap.addType],
  /// or method [newInstance] must be overridden.
  ///
  /// If [stateStore] is not given, [AggregateStateCreator]
  /// must be registered with [AggregateStateTypeMap.addType],
  /// or method [newStateInstance] must be overridden.
  ///
  @mustCallSuper
  AggregateStore(
    EventStore eventStore, {
    EventSerializer<V>? serializer,
    AggregateCreator<V, T>? onNew,
    AggregateStateStore<V, S>? stateStore,
  })  : _onNew = onNew,
        _eventStore = eventStore,
        _stateStore = stateStore,
        _serializer = serializer ?? DefaultEventSerializer<V>() {
    //
    // Sanity checks
    //
    if (_onNew == null && !AggregateTypeMap.contains<V, T>()) {
      throw UnimplementedError('newInstance is not implemented');
    }
    if (_stateStore == null && !AggregateStateTypeMap.contains<V, S>()) {
      throw UnimplementedError('newStateInstance is not implemented');
    }
  }

  /// [AggregateCreator] instance. If not
  /// given, method [newInstance] must be overridden.
  final AggregateCreator<V, T>? _onNew;

  /// [EventStore] loading and storing [StreamEvent]s
  final EventStore _eventStore;

  /// [AggregateStateStore] loading [AggregateState]s
  final AggregateStateStore<V, S>? _stateStore;

  /// [EventSerializer] for serializing and deserializing [Event]s
  late final EventSerializer<V> _serializer;

  /// [AggregateCreator] implementation. If [state] is not given,
  /// a new [AggregateState] instance will be created.
  T call(String id, [S? state]) => newInstance(id, state);

  /// Create new [Aggregate] instance of type [T]
  T newInstance(String id, [S? state]) {
    return _onNew == null
        ? AggregateTypeMap.create<V, T>(id, state)
        : _onNew!(id, state);
  }

  /// Create new [AggregateState] instance of type [S]
  S newStateInstance([V? value]) {
    return _stateStore == null
        ? AggregateStateTypeMap.create<V, S>(value)
        : _stateStore!.newInstance(value);
  }

  /// Load [AggregateState] into given [aggregate] from this store
  /// If aggregate does not exist a AggregateNotFound is thrown.
  @mustCallSuper
  Future<AggregateStateResult<V>> load(String id) async {
    final aggregate = newInstance(
      id,
      await loadState(id),
    );
    final stream = StreamName.fromId<T>(id);
    final start = StreamReadPosition(aggregate.originalVersion);
    try {
      return await _eventStore
          .readStream(stream.value, start)
          .map(_toDomainEvent)
          .map((event) => aggregate.fold(event))
          .last;
    } on StreamNotFound {
      return AggregateStateResult.failure(
        AggregateNotFound<T>(id),
        aggregate,
      );
    } on Exception catch (error) {
      return AggregateStateResult.failure(
        error,
        aggregate,
      );
    }
  }

  /// Load state for [Aggregate] with given [id].
  /// If aggregate for given
  FutureOr<S> loadState(String id, [V? value]) async {
    return _stateStore == null
        ? newStateInstance(value)
        : await _stateStore!.load(StreamName.fromId(id));
  }

  Event<V> _toDomainEvent(StreamEvent event) {
    return _serializer.decode(
      event.data,
      event.name,
    );
  }

  /// Save [AggregateState] of given [aggregate] to this store
  ///
  Future<AggregateStateResult<V>> save(Aggregate<V> aggregate) async {
    if (!aggregate.isChanged) {
      return AggregateStateNoOp(aggregate.current);
    }

    try {
      await _eventStore.appendEvents(
        StreamName.from(aggregate).value,
        aggregate.changes.map(toStreamEvent),
        ExpectedStreamVersion(aggregate.originalVersion),
      );
      // ignore: invalid_use_of_protected_member
      return aggregate.commit();
    } on Exception catch (error) {
      return AggregateStateResult.failure(
        error,
        // ignore: invalid_use_of_protected_member
        aggregate..rollback(),
      );
    }
  }

  StreamEvent toStreamEvent(Event<V> event) {
    return StreamEvent(
      DomainEventTypeMap.getTypeNameFromEvent(event),
      _serializer.encode(event),
      _serializer.contentType,
    );
  }
}
