import 'dart:math';

import 'package:eventuate/eventuate.dart';
import 'package:eventuate/src/event_store_result.dart';

class MemoryEventStore extends EventStore {
  final _global = <StreamEvent>[];
  final _storage = <String, List<StreamEvent>>{};

  @override
  Future<AppendEventsResult> appendEvents(
    String stream,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  ) {
    final next = _storage.update(
      stream,
      (existing) => addToExisting(
        existing,
        events,
        expected,
      ),
      ifAbsent: () => addNew(events),
    );
    _global.addAll(events);
    return Future.value(
      AppendEventsResult.from(_global.length, next.length),
    );
  }

  @override
  Stream<StreamEvent> readStream(
    String stream,
    StreamReadPosition start,
  ) async* {
    for (var event in _findEvents(stream).skip(max(0, start.value))) {
      yield event;
    }
  }

  @override
  Stream<StreamEvent> readStreamBackwards(
    String stream,
    StreamReadPosition start,
  ) async* {
    for (var event in _findEvents(stream).reversed.skip(max(0, start.value))) {
      yield event;
    }
  }

  List<StreamEvent> _findEvents(String stream) {
    final events = _storage[stream];
    if (events == null) {
      throw StreamNotFound.from(stream);
    }
    return List.unmodifiable(events);
  }

  List<StreamEvent> addNew(Iterable<StreamEvent> events) {
    return events.toList();
  }

  List<StreamEvent> addToExisting(
    List<StreamEvent> existing,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  ) {
    if (existing.length >= expected.value) {
      throw WrongExpectedVersion(
        expected,
        existing.length,
      );
    }
    return existing..addAll(events);
  }
}
