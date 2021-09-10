import 'package:eventstore_client/eventstore_client.dart' hide Max;
import 'package:eventuous/eventuous.dart'
    hide StreamNotFoundException, WrongExpectedVersionResult;
import 'package:eventuous/eventuous.dart' as $e;

import 'esdb/extensions.dart';

export 'esdb/extensions.dart';

class EventStoreDB extends StreamEventStore {
  EventStoreDB(
    EventStoreStreamsClient client,
  ) : _client = client;

  factory EventStoreDB.from(
    EventStoreClientSettings settings,
  ) =>
      EventStoreDB(EventStoreStreamsClient(
        settings,
      ));

  factory EventStoreDB.parse(
    String connectionString,
  ) =>
      EventStoreDB(EventStoreStreamsClient(
        EventStoreClientSettings.parse(connectionString),
      ));

  final EventStoreStreamsClient _client;

  @override
  Future<AppendEventsResult> appendEvents(
    StreamName name,
    Iterable<StreamEvent> events,
    ExpectedStreamVersion expected,
  ) async {
    try {
      final request = expected == ExpectedStreamVersion.noStream
          ? _client.append(
              StreamState.noStream(name.value),
              Stream.fromIterable(events.map(_toEventData)),
            )
          : _anyOrNot(
              expected,
              whenAny: () => _client.append(
                StreamState.any(name.value),
                Stream.fromIterable(events.map(_toEventData)),
              ),
              otherwise: () => _client.append(
                StreamState.exists(
                  name.value,
                  revision: expected.asStreamRevision(),
                ),
                Stream.fromIterable(events.map(_toEventData)),
              ),
            );
      final result = await request;
      return result is WrongExpectedVersionResult
          ? $e.WrongExpectedVersionResult(
              name,
              expected,
              ExpectedStreamVersion(result.nextExpectedStreamRevision.toInt()),
              result,
            )
          : AppendEventsResult.ok(
              name,
              result.actualPosition.commitPosition.toInt(),
              result.nextExpectedStreamRevision.toInt(),
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
    try {
      final read = await _client.read(
        name.value,
        position: start.asStreamPosition(),
        maxCount: count,
      );
      final events = await read.events;
      return events.map(_toStreamEvent).toList();
    } on StreamNotFoundException {
      print('error');
      throw $e.StreamNotFoundException(name);
    }
  }

  @override
  Future<Iterable<StreamEvent>> readEventsBackwards(
    StreamName name, [
    int count = Max,
  ]) async {
    try {
      final read = await _client.read(
        name.value,
        forward: false,
        maxCount: count,
      );
      return read.stream.asyncMap(_toStreamEvent).toList();
    } on StreamNotFoundException {
      throw $e.StreamNotFoundException(name);
    }
  }

  @override
  Stream<StreamEvent> readStream(
    StreamName name,
    StreamReadPosition start, [
    int count = Max,
  ]) async* {
    try {
      final read = await _client.subscribe(
        name.value,
        position: start.asStreamPosition(),
      );
      yield* read.stream.asyncMap(_toStreamEvent);
    } on StreamNotFoundException {
      throw $e.StreamNotFoundException(name);
    }
  }

  @override
  Future<void> deleteStream(
    StreamName name,
    ExpectedStreamVersion expected,
  ) async {
    try {
      await _anyOrNot(
        expected,
        whenAny: () => _client.delete(StreamState.any(
          name.value,
        )),
        otherwise: () => _client.delete(StreamState.exists(
          name.value,
          revision: expected.asStreamRevision(),
        )),
      );
    } on StreamNotFoundException {
      throw $e.StreamNotFoundException(name);
    }
  }

  @override
  Future<void> truncateStream(
    StreamName name,
    ExpectedStreamVersion expected,
    StreamTruncatePosition truncate,
  ) async {
    try {
      final metadata = StreamMetadata(
        truncateBefore: truncate.asStreamPosition(),
      );
      await _anyOrNot(
        expected,
        whenAny: () => _client.setStreamMetadata(
          StreamState.any(name.value),
          metadata,
        ),
        otherwise: () => _client.setStreamMetadata(
          StreamState.exists(
            name.value,
            revision: expected.asStreamRevision(),
          ),
          metadata,
        ),
      );
    } on StreamNotFoundException {
      throw $e.StreamNotFoundException(name);
    }
  }

  static Future<T> _anyOrNot<T>(
    ExpectedStreamVersion expected, {
    required Future<T> Function() whenAny,
    required Future<T> Function() otherwise,
  }) =>
      expected == ExpectedStreamVersion.any ? whenAny() : otherwise();

  static EventData _toEventData(StreamEvent streamEvent) => EventData(
        data: streamEvent.data,
        type: streamEvent.eventType,
        metadata: streamEvent.metadata,
        uuid: UuidV4.newUuid().value.uuid,
      );

  static StreamEvent _toStreamEvent(ResolvedEvent resolved) => StreamEvent(
        resolved.event.eventType,
        resolved.event.data,
        resolved.event.contentType,
        resolved.originalEventNumber.toInt(),
        metadata: resolved.event.metadata,
      );
}
