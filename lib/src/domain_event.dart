import 'dart:collection';

typedef DomainEventCreator<T> = DomainEvent<T> Function(T data);
typedef DomainEventList<T> = UnmodifiableListView<DomainEvent<T>>;

abstract class DomainEvent<T> {
  DomainEvent(this.data);
  final T data;
}
