import 'aggregate_state.dart';
import 'domain_event.dart';

typedef EventHandlerCallback<S extends DomainEvent<T>, T> = AggregateState<T>
    Function(S, T);

typedef TypedEventHandlerMap<S extends DomainEvent<T>, T>
    = Map<Type, EventHandlerCallback<S, T>>;

abstract class EventHandler<S extends DomainEvent<T>, T> {
  AggregateState<T> call(S event, T current);
  AggregateState<T> handle(S event, T current);
}
