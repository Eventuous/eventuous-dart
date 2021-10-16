import 'package:eventuous/eventuous.dart';

import 'exceptions.dart';
import 'in_memory_event.dart';

class InMemoryStream {
  InMemoryStream(this.name);

  final StreamName name;

  int get version => _version;
  int _version = -1;

  List<InMemoryEvent> get events => _events.toList();
  final List<InMemoryEvent> _events = [];

  Iterable<InMemoryEvent> appendEvents(
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  ) {
    checkVersion(expected);

    final stored = <InMemoryEvent>[];
    for (var event in events) {
      stored.add(
        InMemoryEvent(event, ++_version),
      );
      _events.add(stored.last);
    }
    return stored;
  }

  void truncate(
    ExpectedStreamVersion version,
    StreamTruncatePosition position,
  ) {
    checkVersion(version);
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

  void checkVersion(ExpectedStreamVersion expected) {
    if (expected.value != _version) {
      throw WrongExpectedVersionException(expected, version);
    }
  }
}
