import 'package:eventuous/eventuous.dart';

typedef EventHandlerCallback<TEvent extends Object, TValue extends Object,
        TState extends AggregateState<TValue>>
    = TState Function(TEvent event, TValue current);

abstract class EventHandler<TEvent extends Object, TValue extends Object,
    TState extends AggregateState<TValue>> {
  TState call(TEvent event, TValue current);
  TState handle(TEvent event, TValue current);
}
