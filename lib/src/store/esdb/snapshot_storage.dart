import 'package:eventstore_client/eventstore_client.dart';
import 'package:eventuous/eventuous.dart' hide WrongExpectedVersionResult;

class EsdbSnapshotStorage<TData extends Object, TValue extends Object,
        TState extends AggregateState<TValue>>
    extends AggregateStateStorage<TValue, TState> {
  EsdbSnapshotStorage(
    EventStoreStreamsClient client, {
    UserCredentials? userCredentials,
    AggregateStateCreator<TValue, TState>? onNew,
    AggregateStateStorageSettings settings =
        AggregateStateStorageSettings.Default,
    EventSerializer<AggregateStateSnapshotModel<TValue>>? serializer,
  })  : _client = client,
        _userCredentials = userCredentials,
        _serializer = serializer ??
            DefaultEventSerializer<TData,
                AggregateStateSnapshotModel<TValue>>(),
        super(onNew: onNew, settings: settings) {
    // Register as event type for serialization support
    EventType.addType<JsonMap, AggregateStateSnapshotModel<TValue>>(
      (data) => AggregateStateSnapshotModel.fromJson(data),
    );
  }

  final EventStoreStreamsClient _client;
  final UserCredentials? _userCredentials;
  final EventSerializer<AggregateStateSnapshotModel<TValue>> _serializer;

  @override
  Future<AggregateStateSnapshotModel<TValue>?> read(StreamName name) async {
    final result = await _client.read(
      _toSnapshotStreamId(name),
      forward: false,
      maxCount: 1,
      userCredentials: _userCredentials,
    );

    if (result.isOK) {
      final events = await result.events;
      if (events.isNotEmpty) {
        return _serializer.decode(
          events.last.originalEvent.data,
          '${typeOf<AggregateStateSnapshotModel<TValue>>()}',
        );
      }
    }
  }

  @override
  Future<void> write(
    StreamName name,
    AggregateStateSnapshotModel<TValue> snapshot,
  ) async {
    final streamId = _toSnapshotStreamId(name);
    final result = await _client.append(
      StreamState.any(streamId),
      Stream.fromIterable([
        EventData(
          uuid: UuidV4.newUuid().value.uuid,
          type: '$TState',
          data: _serializer.encode(snapshot),
        )
      ]),
    );
    if (result is WrongExpectedVersionResult) {
      throw ConcurrentModificationException(
        StreamName(streamId),
        result.expected.revision == null
            ? ExpectedStreamVersion.noStream
            : ExpectedStreamVersion(result.expected.revision!.toInt()),
        ExpectedStreamVersion(result.nextExpectedStreamRevision.toInt()),
      );
    }
  }

  String _toSnapshotStreamId(StreamName name) => 'snapshot-${name.value}';
}
