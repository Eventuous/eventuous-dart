import 'package:eventuous/eventuous.dart';

typedef EventHandlerCallback<S extends Event<T>, T> = AggregateState<T>
    Function(S, T);

typedef EventHandlerMap<S extends Event<T>, T>
    = Map<Type, EventHandlerCallback<S, T>>;

abstract class EventHandler<S extends Event<T>, T> {
  AggregateState<T> call(S event, T current);
  AggregateState<T> handle(S event, T current);
}
