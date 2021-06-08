import 'package:eventuate/src/version.dart';

import 'event_store_result.dart';
import 'stream_event.dart';

/// Store of [StreamEvent]s used by [AggregateStore].
abstract class EventStore {
  Future<Iterable<StreamEvent>> readEvents(
    String stream,
    StreamReadPosition start,
    int count,
  ) =>
      readStream(stream, start).take(count).toList();

  Future<Iterable<StreamEvent>> readEventsBackwards(
    String stream,
    StreamReadPosition start,
    int count,
  ) =>
      readStreamBackwards(stream, start).take(count).toList();

  Stream<StreamEvent> readStream(
    String stream,
    StreamReadPosition start,
  );

  Stream<StreamEvent> readStreamBackwards(
    String stream,
    StreamReadPosition start,
  );

  Future<AppendEventsResult> appendEvents(
    String stream,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  );
}
