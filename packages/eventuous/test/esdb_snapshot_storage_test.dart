import 'package:eventuous/eventuous.dart';
import 'package:eventuous_test/eventuous_test.dart';
import 'package:test/test.dart';

import 'domain/booking/booking.dart';

typedef EsdbBookingStateStorage
    = EsdbSnapshotStorage<JsonMap, BookingStateModel, BookingState>;

void main() {
  group('When saving aggregate state to EventStoreDB', () {
    var index = 0;
    String nextStreamId() => 'stream-${++index}';
    late EventStoreDB esdb;
    late EventStoreServerSingleNode server;
    setUpAll(() async {
      defineBookingTypes();
      // Register BookingState snapshot event type
      AggregateEventTypes.define<JsonMap, BookingStateModel>(
        (data) => BookingStateModel.fromJson(data),
      );
      server = EventStoreServerSingleNode(EventStoreImage.LTS);
      await server.start();
      esdb = EventStoreDB.parse('esdb://localhost:2113?tls=false');
      return server;
    });
    tearDownAll(() async {
      await server.stop();
    });

    test(
      'snapshots are not saved eagerly',
      () async {
        // Arrange
        final storage = EsdbBookingStateStorage(esdb.client);
        final name = StreamName(nextStreamId());
        final state = storage.newInstance();

        // Act
        await storage.save(name, state);

        // Assert
        expect(storage.contains(name), isFalse);
      },
      // TODO: Solve unstable test
      retry: 2,
    );

    test('snapshots are not cached', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'bookingId': 'value',
      };
      final roomBooked = AggregateEventTypes.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final storage = EsdbBookingStateStorage(
        esdb.client,
        settings: AggregateStateStorageSettings(
          eager: true,
        ),
      );
      final name = StreamName(nextStreamId());
      final state = storage.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await storage.save(name, state0);

      // Assert
      expect(storage.contains(name), isFalse);
    });

    test('snapshots are saved eagerly', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'bookingId': 'value',
      };
      final roomBooked = AggregateEventTypes.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final storage = EsdbBookingStateStorage(
        esdb.client,
        settings: AggregateStateStorageSettings(
          eager: true,
          useCache: true,
        ),
      );
      final name = StreamName(nextStreamId());
      final state = storage.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await storage.save(name, state0);

      // Assert
      expect(storage.contains(name), isTrue);
    });

    test('snapshots are not saved for states with version == -1', () async {
      // Arrange
      final storage = EsdbBookingStateStorage(
        esdb.client,
        settings: AggregateStateStorageSettings(
          eager: false,
          threshold: 0,
        ),
      );
      final name = StreamName(nextStreamId());

      // State with version == -1
      final state = storage.newInstance();

      // Act
      await storage.save(name, state);

      // Assert
      expect(storage.contains(name), isFalse);
    });

    test('snapshots are saved when threshold is exceeded', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'bookingId': 'value',
      };
      final roomBooked = AggregateEventTypes.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final storage = EsdbBookingStateStorage(
        esdb.client,
        settings: AggregateStateStorageSettings(
          eager: false,
          threshold: 0,
          useCache: false,
        ),
      );
      final name = StreamName(nextStreamId());

      // State with version == 1
      final state = storage.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);
      final state1 = state0.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await storage.save(name, state1);
      final loaded = await storage.load(name);

      // Assert
      expect(storage.contains(name), isFalse);
      expect(loaded, state1);
    });
  });
}
