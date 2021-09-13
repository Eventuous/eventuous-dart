import 'package:eventuous/eventuous.dart';
import 'package:meta/meta.dart';

/// Base class for storing snapshots of [AggregateState].
///
/// Snapshots are the representation of the current state
/// at a certain "point in time", and it is an optimization
/// that is considered and anti-pattern in general. Streams
/// with many events indicates usually that the model is wrong.
/// In general each stream should contain events from an aggregate
/// instance (instance streams) only, which normally implies a
/// small number of events in each stream. In such cases, it is
/// better to just read all events and fold them onto the state.
/// Snapshotting could be a good fit if the number of events are
/// large though. For more on how to implement snapshotting,
/// see [Snapshotting strategies](https://www.eventstore.com/blog/snapshotting-strategies)
/// and [Snapshots in Event sourcing](https://www.eventstore.com/blog/snapshots-in-event-sourcing).
///
/// Use [settings] to control snapshot behavior. Default is
/// one snapshot each 1000 events (eager mode will produce
/// a snapshot on first [save], default false).
///
/// Override methods [read] and [write] to implement
/// persistent storage. If in-memory caching is needed,
/// [AggregateStateStorageSettings.useCache] must be [true].
///
/// If [onNew] is not given, [AggregateStateCreator]
/// must be registered with [AggregateStateTypes.define],
/// or method [newInstance] must be overridden (implements
/// [AggregateStateCreator] as default method).
///
/// * Type parameter [TValue] - [AggregateState.value] type
/// * Type parameter [TState] - [AggregateState] type
///
abstract class AggregateStateStorage<TValue extends Object,
    TState extends AggregateState<TValue>> {
  /// Default constructor.
  ///
  /// If [onNew] is not given, [AggregateStateCreator]
  /// must be registered with [AggregateStateTypes.define],
  /// or method [newInstance] must be overridden.
  ///
  AggregateStateStorage({
    AggregateStateCreator<TValue, TState>? onNew,
    this.settings = AggregateStateStorageSettings.Default,
  }) : _onNew = onNew {
    //
    // Sanity checks
    //
    if (_onNew == null && !AggregateStateTypes.containsType(TState)) {
      throw UnimplementedError('newInstance is not implemented for $TState');
    }
  }

  /// [AggregateStateCreator] instance
  final AggregateStateCreator<TValue, TState>? _onNew;

  /// Create new [AggregateState] instance with
  /// [AggregateState.value] of [TValue]. If [value]
  /// is not given, a default value is used.
  TState newInstance([TValue? value, int? version]) {
    return _onNew == null
        ? AggregateStateTypes.create<TValue, TState>(value, version)
        : _onNew!(value, version);
  }

  /// Snapshot settings
  final AggregateStateStorageSettings settings;

  // Internal in-memory reference to last snapshot
  final Map<StreamName, _Snapshot<TValue, TState>> _states = {};

  /// Read [TState] for given [name] from storage.
  Future<AggregateStateSnapshotModel<TValue>?> read(StreamName name);

  /// Write [snapshot] of [TState] for given [name] to storage
  Future<void> write(
    StreamName name,
    AggregateStateSnapshotModel<TValue> snapshot,
  );

  /// Load [AggregateState] of type [TState] for given [StreamName].
  @mustCallSuper
  Future<TState> load(StreamName name) async {
    invalidate();
    return _states[name]?.state ?? await _read(name) ?? newInstance();
  }

  Future<TState?> _read(StreamName name) async {
    final snapshot = await read(name);
    if (snapshot != null) {
      return newInstance(
        snapshot.value,
        snapshot.version,
      );
    }
  }

  /// Save [AggregateState] of type [TState] for given [StreamName].
  @mustCallSuper
  Future<void> save(StreamName name, TState state) async {
    if (await shouldSnapshot(name, state)) {
      await write(
        name,
        AggregateStateSnapshotModel(state.value, state.version),
      );
      if (settings.useCache) {
        _states[name] = _Snapshot<TValue, TState>(state);
      }
    }
  }

  /// Check if cache contains state for given [name]
  bool contains(StreamName name) =>
      settings.useCache && _states.containsKey(name);

  /// Invalidate in-memory cache of snapshots
  int invalidate() {
    final now = DateTime.now();
    final invalid = _states.entries
        .where((s) => s.value.isInvalid(now, settings.ttl))
        .toList();
    invalid.forEach(_states.remove);
    return invalid.length;
  }

  /// Test if given [state] of stream [name] should be taken snapshot of
  Future<bool> shouldSnapshot(StreamName name, TState state) async {
    final snapshot = _states[name]?.state ?? await _read(name);
    return state.version > ExpectedStreamVersion.noStream.value &&
        (snapshot == null &&
                // Eager snapshot?
                (settings.eager || state.version > settings.threshold) ||
            snapshot != null &&
                // Threshold exceeded?
                (state.version - snapshot.version) > settings.threshold);
  }
}

class AggregateStateStorageSettings {
  /// Construct an [AggregateStateStorageSettings] instance
  const AggregateStateStorageSettings({
    this.ttl = TTL,
    this.eager = false,
    this.useCache = false,
    this.threshold = 1000,
  });

  /// Default time-to-live is one day
  static const TTL = Duration(days: 1);

  /// Default settings
  static const Default = AggregateStateStorageSettings();

  /// If [true] a snapshot is made on first [AggregateStateSnapshotStore.save]
  final bool eager;

  /// Time to live in memory
  final Duration ttl;

  /// If [true] state is cached in memory on [save]
  final bool useCache;

  /// Maximum number state versions applied between each snapshot
  final int threshold;
}

class _Snapshot<TValue extends Object, TState extends AggregateState<TValue>> {
  final TState state;
  final DateTime timestamp = DateTime.now();

  _Snapshot(this.state);

  bool isInvalid(DateTime now, Duration ttl) {
    return now.difference(timestamp) > ttl;
  }
}
