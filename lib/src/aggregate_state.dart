import 'package:eventuate/eventuate.dart';

import 'domain_event.dart';
import 'event_handler.dart';

part 'aggregate_state_result.dart';

/// New [AggregateState] instance creator method.
/// If [value] is not given, a default value must
/// be given.
typedef AggregateStateCreator<S, T extends AggregateState<S>> = T Function([
  S? value,
]);

/// [AggregateState] base class.
abstract class AggregateState<T> {
  AggregateState(
    this.value, {
    int version = -1,
  }) : _version = version;

  // ignore: prefer_collection_literals
  final _handlers = TypedEventHandlerMap<DomainEvent<T>, T>();

  /// Get state value of type [T]
  final T value;

  /// The current version of [AggregateState].
  /// Is incremented [when] an event is handled.
  int get version => _version;
  int _version;

  /// Handle [DomainEvent].
  /// Returns [value] after event is handled.
  /// If given [event] is not handled by this
  /// state, original [value] is returned.
  ///
  AggregateState<T> when(DomainEvent<T> event) {
    final eventType = event.runtimeType;
    if (!_handlers.containsKey(eventType)) {
      return this;
    }
    return _handlers[eventType]!(event, value).._version = _version + 1;
  }

  /// Register handler for given event
  void on<S extends DomainEvent<T>>(
    EventHandlerCallback<DomainEvent<T>, T> handler,
  ) {
    if (_handlers.containsKey(typeOf<S>())) {
      throw ArgumentError('Duplicate handler for event type ${typeOf<S>()}');
    }
    _handlers[typeOf<S>()] = handler;
  }

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
