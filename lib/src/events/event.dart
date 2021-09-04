import 'dart:collection';

typedef EventCreator<T> = Event<T> Function(T data);
typedef EventList<T> = UnmodifiableListView<Event<T>>;

abstract class Event<T> {
  Event(this.data);
  final T data;
}
