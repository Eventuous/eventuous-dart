import 'package:eventuous/eventuous.dart';

import 'in_memory_stream.dart';

class InMemoryEventStore extends EventStore {
  final _global = <StreamEvent>[];
  final _storage = <StreamName, InMemoryStream>{};

  @override
  Future<AppendEventsResult> appendEvents(
    StreamName name,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  ) {
    final next = _storage.putIfAbsent(
      name,
      () => InMemoryStream(name),
    );
    next.appendEvents(events, expected);
    _global.addAll(events);
    return Future.value(
      AppendEventsResult.from(
        _global.length,
        next.version,
      ),
    );
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
  Stream<StreamEvent> readStreamBackwards(
    StreamName name, [
    int count = Max,
  ]) async* {
    for (var event in _findStream(name).getEventsBackwards(count)) {
      yield event;
    }
  }

  InMemoryStream _findStream(StreamName name) {
    final stream = _storage[name];
    if (stream == null) {
      throw StreamNotFoundException.from(name);
    }
    return stream;
  }
}
