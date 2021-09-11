import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'fixtures/harness.dart';

void main() {
  group('When saving aggregate state', () {
    setUpAll(() {
      addBookingTypes();
    });

    test('snapshots are not saved eagerly', () async {
      // Arrange
      final store = BookingStateStore();
      final name = StreamName('stream');
      final state = store.newInstance();

      // Act
      await store.save(name, state);

      // Assert
      expect(store.contains(name), isFalse);
      expect(store.hasSnapshot(name), isFalse);
    });

    test('snapshots are not cached', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'bookingId': 'value',
      };
      final roomBooked = EventType.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final store = BookingStateStore(
        settings: AggregateStateStorageSettings(
          eager: true,
        ),
      );
      final name = StreamName('stream');
      final state = store.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await store.save(name, state0);

      // Assert
      expect(store.contains(name), isFalse);
      expect(store.hasSnapshot(name), isTrue);
    });

    test('snapshots are saved and cached eagerly', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'bookingId': 'value',
      };
      final roomBooked = EventType.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final store = BookingStateStore(
        settings: AggregateStateStorageSettings(
          eager: true,
          useCache: true,
        ),
      );
      final name = StreamName('stream');
      final state = store.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await store.save(name, state0);

      // Assert
      expect(store.contains(name), isTrue);
      expect(store.hasSnapshot(name), isTrue);
    });

    test('snapshots are not saved for states with version == -1', () async {
      // Arrange
      final store = BookingStateStore(
        settings: AggregateStateStorageSettings(
          eager: false,
          threshold: 0,
        ),
      );
      final name = StreamName('stream');

      // State with version == -1
      final state = store.newInstance();

      // Act
      await store.save(name, state);

      // Assert
      expect(store.contains(name), isFalse);
      expect(store.hasSnapshot(name), isFalse);
    });

    test('snapshots are saved when threshold is exceeded', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'bookingId': 'value',
      };
      final roomBooked = EventType.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final store = BookingStateStore(
        settings: AggregateStateStorageSettings(
          eager: false,
          threshold: 0,
          useCache: false,
        ),
      );
      final name = StreamName('stream');

      // State with version == 1
      final state = store.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);
      final state1 = state0.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await store.save(name, state1);

      // Assert
      expect(store.contains(name), isFalse);
      expect(store.hasSnapshot(name), isTrue);
    });
  });
}
