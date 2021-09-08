import 'package:eventuous/eventuous.dart';

part 'aggregate_state_result.dart';

/// New [AggregateState] instance creator method.
/// If [value] is not given, a default value must
/// be given.
typedef AggregateStateCreator<TState extends Object,
        TAggregate extends AggregateState<TState>>
    = TAggregate Function([
  TState? value,
]);

/// [AggregateState] base class.
abstract class AggregateState<TValue extends Object> {
  AggregateState(
    this.value, {
    int version = -1,
  }) : _version = version;

  final _handlers = <Type, Object>{};

  /// Get state value of type [TValue]
  final TValue value;

  /// The current version of [AggregateState].
  /// Is incremented [when] an event is handled.
  int get version => _version;
  int _version;

  /// Handle [event].
  /// Returns [value] after event is handled.
  /// If given [event] is not handled by this
  /// state, original [value] is returned.
  ///
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
      other is AggregateState &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          version == other.version;

  @override
  int get hashCode => value.hashCode ^ version.hashCode;
}
