import 'package:eventuous/eventuous.dart';

import 'exceptions.dart';
import 'stored_event.dart';

class InMemoryStream {
  InMemoryStream(this.name);

  final StreamName name;

  int get version => _version;
  int _version = -1;

  List<StoredEvent> get events => _events.toList();
  final List<StoredEvent> _events = [];

  void appendEvents(
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  ) {
    _checkVersion(expected);

    for (var event in events) {
      _events.add(StoredEvent(event, ++_version));
    }
  }

  void truncate(
    ExpectedStreamVersion version,
    StreamTruncatePosition position,
  ) {
    _checkVersion(version);
    _events.removeWhere((e) => e.position <= position.value);
  }

  Iterable<StreamEvent> getEvents(StreamReadPosition from, int count) {
    return _events
        .skipWhile((e) => e.position < from.value)
        .take(count)
        .map((e) => e.event);
  }

  Iterable<StreamEvent> getEventsBackwards(int count) {
    return _events.reversed.take(count).map((e) => e.event);
  }

  void _checkVersion(ExpectedStreamVersion expected) {
    if (expected.value != _version) {
      throw WrongExpectedVersionException(expected, version);
    }
  }
}
