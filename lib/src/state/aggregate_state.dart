part of 'aggregate.dart';

/// New [AggregateState] instance creator method.
/// If [value] is not given, a default value must
/// be given.
typedef AggregateStateCreator<TValue extends Object,
        TState extends AggregateState<TValue>>
    = TState Function([TValue? value, int? version]);

/// [AggregateState] base class.
abstract class AggregateState<TValue extends Object> {
  AggregateState(this.value, [int? version]) : _version = version ?? -1;

  final _handlers = <Type, Object>{};

  /// Get state value of type [TValue]
  final TValue value;

  /// The current version of [AggregateState].
  /// Is incremented [when] an event is handled.
  int get version => _version;
  int _version = ExpectedStreamVersion.noStream.value;

  /// Handle [event].
  /// Returns [value] after event is handled.
  /// If given [event] is not handled by this
  /// state, original [value] is returned.
  ///
  @mustCallSuper
  TState when<TEvent extends Object, TState extends AggregateState<TValue>>(
    TEvent event,
  ) {
    final eventType = event.runtimeType;
    if (!_handlers.containsKey(eventType)) {
      throw UnknownEventException(eventType, 'Handler not found');
    }
    return (_handlers[eventType]!
        as EventHandlerCallback<TEvent, TValue, TState>)(event, value)
      .._version = _version + 1;
  }

  /// Register handler for given event
  void on<TEvent extends Object>(
    EventHandlerCallback<TEvent, TValue, AggregateState<TValue>> handler,
  ) {
    if (_handlers.containsKey(typeOf<TEvent>())) {
      throw ArgumentError(
          'Duplicate handler for event type ${typeOf<TEvent>()}');
    }
    _handlers[typeOf<TEvent>()] = handler;
  }

  /// Get [ExpectedStreamVersion] on next [AggregateStore.save]
  ExpectedStreamVersion get expectedVersion => ExpectedStreamVersion(version);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AggregateState<TValue> &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          version == other.version;

  @override
  int get hashCode => value.hashCode ^ version.hashCode;

  @override
  String toString() {
    return '$runtimeType{value: $value, version: $version}';
  }
}
