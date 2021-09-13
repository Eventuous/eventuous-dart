import 'dart:async';
import 'dart:collection';

import 'package:eventuous/eventuous.dart';
import 'package:meta/meta.dart';

part 'aggregate_state.dart';
part 'aggregate_state_result.dart';
part 'aggregate_store.dart';

/// [Aggregate] instance creator method. If [state] is
/// not given, a new [AggregateState] instance must be
/// created.
typedef AggregateCreator<
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    = TAggregate Function(TId id, [TState? state]);

/// Base class for implementing a model within a specific domain
///
/// * Type parameter [TState] - [AggregateState.value] type
///
abstract class Aggregate<TEvent extends Object, TValue extends Object,
    TId extends AggregateId, TState extends AggregateState<TValue>> {
  /// Default constructor that set [initial] state.
  /// Must be called by subclasses.
  ///
  @mustCallSuper
  Aggregate(
    this.id,
    TState original,
  ) {
    _current = original;
    _original = original;
  }

  /// Get unique [AggregateId] of type [TId]
  ///
  final TId id;

  /// [AggregateState] before first [Event]
  /// applied locally. Is always equal to [original]
  /// after [load].
  TState get current => _current;
  late TState _current;

  /// [AggregateState] after last [Event]
  /// applied or folded onto it. Is always equal to
  /// [original] after creation, [load], [commit]
  /// and [rollback].
  ///
  TState get original => _original;
  late TState _original;

  /// The aggregate version got from [AggregateStore]
  /// on last [load]. Used for optimistic concurrency
  /// checks to ensure that there were no changed made
  /// to the [AggregateState] since last load.
  ///
  int get originalVersion => _original.version;

  /// The current version of [AggregateState]. Is
  /// incremented each time an event is [fold]ed
  /// onto the state. If [currentVersion] is
  /// greater than [originalVersion] this implies
  /// that there are [changes] made locally.
  ///
  int get currentVersion => _current.version;

  /// Get [ExpectedStreamVersion] on next [AggregateStore.save]
  ExpectedStreamVersion get expectedVersion => ExpectedStreamVersion(
        originalVersion,
      );

  /// Get list of pending changes [Event]s folded into [current] state
  AggregateEventList<TEvent> get changes => UnmodifiableListView(_changes);
  final _changes = <TEvent>[];

  /// Check if local [changes] exists
  bool get isChanged => _changes.isNotEmpty;

  /// Load current state from given [events].
  /// If aggregate is already loaded or
  /// changed, an DomainException is thrown.
  ///
  AggregateStateResult<TEvent, TValue, TId, TState> load(
      Iterable<TEvent> events) {
    if (currentVersion > -1) {
      throw DomainException(
        '$runtimeType is already ${isChanged ? 'created' : 'loaded'}',
      );
    }
    _current = events.fold(
      _original,
      (previous, event) => previous.when<TEvent, TState>(event),
    );
    // _current._version = events.length - 1;
    return AggregateStateResult.ok(
      current: _current,
      previous: _original,
    );
  }

  /// Fold given [event] on [current] state.
  ///
  AggregateStateResult<TEvent, TValue, TId, TState> fold(TEvent event) {
    final previous = _current;
    _current = previous.when<TEvent, TState>(event);
    return AggregateStateResult.ok(
      current: _current,
      previous: previous,
    );
  }

  /// Apply [event] to current state.
  /// If successful the event is added to
  /// [changes] and [current] version is
  /// incremented by 1.
  AggregateStateResult<TEvent, TValue, TId, TState> apply(TEvent event) {
    final previous = _current;
    _current = previous.when<TEvent, TState>(event);
    if (_current == previous) {
      return AggregateStateNoOp(
        _current,
      );
    }
    _changes.add(event);
    return AggregateStateResult.ok(
      current: _current,
      previous: previous,
    );
  }

  /// Commit local [changes] to [original] state.
  @visibleForOverriding
  AggregateStateResult<TEvent, TValue, TId, TState> commit() {
    _changes.clear();
    final previous = _original;
    _original = _current;
    return AggregateStateResult.ok(
      current: _current,
      previous: previous,
    );
  }

  /// Rollback local [changes] to [original] state.
  @visibleForOverriding
  AggregateStateResult<TEvent, TValue, TId, TState> rollback() {
    if (_original.expectedVersion == ExpectedStreamVersion.noStream) {
      _changes.clear();
    } else {
      final diff = _current.version - _original.version;
      _changes.removeRange(
        _changes.length - diff,
        _changes.length,
      );
    }
    final previous = _current;
    _current = _original;
    return AggregateStateResult.ok(
      current: _current,
      previous: previous,
    );
  }

  /// Subclasses of [Aggregate] should use this method
  /// to ensure that is is operating on an existing [Aggregate].
  @protected
  void ensureExists() {
    if (currentVersion == -1) {
      throw AggregateNotFoundException(runtimeType, id);
    }
  }

  /// Subclasses of [Aggregate] should use this method
  /// to ensure that is is operating on a new [Aggregate].
  @protected
  void ensureDoesntExists() {
    if (currentVersion > -1) {
      throw AggregateExistsException(runtimeType, id);
    }
  }
}
