import 'dart:collection';

import 'package:eventuate/eventuate.dart';
import 'package:eventuate/src/aggregate_id.dart';
import 'package:meta/meta.dart';

import 'aggregate_state.dart';
import 'domain_event.dart';
import 'exceptions.dart';

/// [Aggregate] instance creator method. If [state] is
/// not given, a new [AggregateState] instance must be
/// created.
typedef AggregateCreator<S, T extends Aggregate<S>> = T Function(
  String id, [
  AggregateState<S>? state,
]);

/// Base class for implementing a model within a specific domain
///
/// Type parameter [T] - [AggregateState.value] type
///
abstract class Aggregate<T> {
  /// Default constructor that set [initial] state.
  /// Must be called by subclasses.
  ///
  @mustCallSuper
  Aggregate(
    this.id,
    AggregateState<T> original,
  ) {
    _current = original;
    _original = original;
  }

  /// Get unique [AggregateId]
  ///
  final AggregateId id;

  /// [AggregateState] before first [DomainEvent]
  /// applied locally. Is always equal to [_original]
  /// after [load].
  AggregateState<T> get current => _current;
  late AggregateState<T> _original;

  /// [AggregateState] after last [DomainEvent]
  /// applied or folded onto it. Is always equal to
  /// [_original] after creation, [load], [commit]
  /// and [rollback].
  ///
  AggregateState<T> get original => _original;
  late AggregateState<T> _current;

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
  /// that [changes] are made locally.
  ///
  int get currentVersion => _current.version;

  /// Get list of pending changes made by
  /// [DomainEvent]s applied locally.
  ///
  DomainEventList<T> get changes => UnmodifiableListView(_changes);
  final _changes = <DomainEvent<T>>[];

  /// Check if local [changes] exists
  bool get isChanged => _changes.isNotEmpty;

  /// Load current state from given [events].
  /// If aggregate is already loaded or
  /// changed, an DomainException is thrown.
  ///
  AggregateStateResult<T> load(Iterable<DomainEvent<T>> events) {
    if (currentVersion > -1) {
      throw DomainException(
        '$runtimeType is already ${isChanged ? 'created' : 'loaded'}',
      );
    }
    _current = events.fold(
      _original,
      (previous, event) => previous.when(event),
    );
    return AggregateStateResult.from(
      current: _current,
      previous: _original,
    );
  }

  /// Fold given [event] on [current] state.
  ///
  AggregateStateResult<T> fold(DomainEvent<T> event) {
    final previous = _current;
    _current = previous.when(event);
    return AggregateStateResult.from(
      current: _current,
      previous: previous,
    );
  }

  /// Apply [event] to current state.
  /// If successful the event is added to
  /// [changes] and [current] version is
  /// incremented by 1.
  AggregateStateResult<T> apply(DomainEvent<T> event) {
    final previous = _current;
    _current = previous.when(event);
    _changes.add(event);
    return AggregateStateResult.from(
      current: _current,
      previous: previous,
    );
  }

  /// Commit local [changes] to [original] state.
  @protected
  AggregateStateResult<T> commit() {
    _changes.clear();
    final previous = _original;
    _original = _current;
    return AggregateStateResult.from(
      current: _current,
      previous: previous,
    );
  }

  /// Rollback local [changes] to [original] state.
  @protected
  AggregateStateResult<T> rollback() {
    _changes.clear();
    final previous = _current;
    _current = _original;
    return AggregateStateResult.from(
      current: _current,
      previous: previous,
    );
  }

  /// Subclasses of [Aggregate] should use this method
  /// to ensure that is is operating on an existing [Aggregate].
  @protected
  void ensureExists() {
    if (currentVersion == -1) {
      throw DomainException("$runtimeType doesn't exist: $id");
    }
  }

  /// Subclasses of [Aggregate] should use this method
  /// to ensure that is is operating on a new [Aggregate].
  @protected
  void ensureDoesntExists() {
    if (currentVersion > -1) {
      throw DomainException('$runtimeType already exist: $id');
    }
  }
}
