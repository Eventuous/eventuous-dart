import 'package:eventuous/eventuous.dart';

/// Store of [StreamEvent]s used by [AggregateStore].
abstract class EventStore {
  Future<Iterable<StreamEvent>> readEvents(
    StreamName name,
    StreamReadPosition start, [
    int count = Max,
  ]);

  Future<Iterable<StreamEvent>> readEventsBackwards(
    StreamName name, [
    int count = Max,
  ]);

  Stream<StreamEvent> readStream(
    StreamName name,
    StreamReadPosition start, [
    int count = Max,
  ]);

  Stream<StreamEvent> readStreamBackwards(
    StreamName name, [
    int count = Max,
  ]);

  Future<AppendEventsResult> appendEvents(
    StreamName name,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  );
}
