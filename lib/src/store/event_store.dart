import 'package:eventuous/eventuous.dart';

import 'event_store_result.dart';

/// Store of [StreamEvent]s used by [AggregateStore].
abstract class StreamEventStore {
  /// Append one or more events to a stream
  /// Parameter [name] identifies stream to append
  /// [events] to. Use parameter [expected] to
  /// indicate which stream version that was
  /// last seen. Is used to perform consistency
  /// checks based on optimistic locking.
  Future<AppendEventsResult> appendEvents(
    StreamName name,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  );

  /// Read a fixed number of events from an existing stream
  /// Parameter [name] identifies stream to read from.
  /// Use parameter [start] to define the position
  /// in the stream to start reading from. Use [count]
  /// to limit number of events that is read from
  /// the stream (default is [Max] which returns all
  /// events from [start]).
  Future<Iterable<StreamEvent>> readEvents(
    StreamName name,
    StreamReadPosition start, [
    int count = Max,
  ]);

  /// Read a fixed number of events from an existing stream
  /// backwards from last event.
  /// Parameter [name] identifies stream to read from.
  /// Use [count] to limit number of events that is read
  /// from the stream (default is [Max] which returns all
  /// events from given stream).
  Future<Iterable<StreamEvent>> readEventsBackwards(
    StreamName name, [
    int count = Max,
  ]);

  /// Read events asynchronously as a [Stream].
  /// Parameter [name] identifies stream to read from.
  /// Use parameter [start] to define the position
  /// in the stream to start reading from. Use [count]
  /// to limit number of events that is read from
  /// the stream (default is [Max] which returns all
  /// events from [start]).
  Stream<StreamEvent> readStream(
    StreamName name,
    StreamReadPosition start, [
    int count = Max,
  ]);

  /// Truncate all events on the stream upto given position
  /// Parameter [name] identifies stream to truncate events from.
  /// Parameter [truncate] is the position on stream to truncate
  /// events from. Use parameter [expected] to indicate which stream
  /// version that was last seen. Is used to perform consistency
  /// checks based on optimistic locking
  Future<void> truncateStream(
    StreamName name,
    ExpectedStreamVersion expected,
    StreamTruncatePosition truncate,
  );

  /// Delete a stream. The stream can not be used again.
  /// Parameter [name] identifies stream to truncate events
  /// from. Use parameter [expected] to indicate which stream
  /// version that was last seen. Is used to perform consistency
  /// checks based on optimistic locking
  Future<void> deleteStream(
    StreamName name,
    ExpectedStreamVersion expected,
  );
}
