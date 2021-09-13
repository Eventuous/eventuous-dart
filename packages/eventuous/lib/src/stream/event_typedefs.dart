import 'dart:collection';

typedef AggregateEventCreator<TData extends Object, TEvent extends Object>
    = TEvent Function(TData data);

typedef AggregateEventList<TEvent extends Object>
    = UnmodifiableListView<TEvent>;
