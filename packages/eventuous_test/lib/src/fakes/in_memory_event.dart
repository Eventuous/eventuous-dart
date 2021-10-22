import 'package:eventuous/eventuous.dart';

class InMemoryEvent {
  InMemoryEvent(this.event, this.position);

  final StreamEvent event;
  final int position;
}
