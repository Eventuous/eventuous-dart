import 'dart:collection';

typedef EventCreator<TData extends Object, TEvent extends Object> = TEvent
    Function(TData data);

typedef EventList<TEvent extends Object> = UnmodifiableListView<TEvent>;
