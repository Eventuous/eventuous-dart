import 'package:eventuous/eventuous.dart';

import 'exceptions.dart';
import 'in_memory_stream.dart';
import 'stored_event.dart';

class InMemoryEventStore extends StreamEventStore {
  final _global = <StoredEvent>[];
  final _storage = <StreamName, InMemoryStream>{};

  @override
  Future<AppendEventsResult> appendEvents(
    StreamName name,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  ) async {
    try {
      final next = _storage.putIfAbsent(
        name,
        () => InMemoryStream(name),
      );
      _global.addAll(
        next.appendEvents(events, expected),
      );
      return AppendEventsResult.ok(
        name,
        _global.length,
        next.version,
      );
    } on WrongExpectedVersionException catch (cause) {
      return WrongExpectedVersionResult(
        name,
        cause.expectedVersion,
        ExpectedStreamVersion(cause.actualVersion),
        cause,
      );
    } on Exception catch (cause) {
      return AppendEventsResult.error(
        name,
        expected.value,
        cause,
      );
    }
  }

  @override
  Future<Iterable<StreamEvent>> readEvents(
    StreamName name,
    StreamReadPosition start, [
    int count = Max,
  ]) async {
    return _findStream(name).getEvents(start, count);
  }

  @override
  Future<Iterable<StreamEvent>> readEventsBackwards(
    StreamName name, [
    int count = Max,
  ]) async {
    return _findStream(name).getEventsBackwards(count);
  }

  @override
  Stream<StreamEvent> readStream(
    StreamName name,
    StreamReadPosition start, [
    int count = Max,
  ]) async* {
    for (var event in _findStream(name).getEvents(start, count)) {
      yield event;
    }
  }

  @override
  Future<void> deleteStream(
    StreamName name,
    ExpectedStreamVersion expected,
  ) async {
    final stream = _findStream(name)..checkVersion(expected);
    stream.events.forEach(_global.remove);
    _storage.remove(name);
  }

  @override
  Future<void> truncateStream(
    StreamName name,
    ExpectedStreamVersion expected,
    StreamTruncatePosition truncate,
  ) async {
    _findStream(name).truncate(expected, truncate);
  }

  InMemoryStream _findStream(StreamName name) {
    final stream = _storage[name];
    if (stream == null) {
      throw StreamNotFoundException(name);
    }
    return stream;
  }
}
