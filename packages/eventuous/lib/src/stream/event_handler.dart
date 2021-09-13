import 'package:eventuous/eventuous.dart';

typedef AggregateEventHandlerCallback<TEvent extends Object,
        TValue extends Object, TState extends AggregateState<TValue>>
    = TState Function(TEvent event, TValue current);

abstract class AggregateEventHandler<TEvent extends Object,
    TValue extends Object, TState extends AggregateState<TValue>> {
  TState call(TEvent event, TValue current);

  TState handle(TEvent event, TValue current);
}
