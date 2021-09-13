import 'package:eventuous/eventuous.dart';

class StoredEvent {
  StoredEvent(this.event, this.position);

  final StreamEvent event;
  final int position;
}
