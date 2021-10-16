import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'domain/booking/booking.dart';

void main() {
  group('When saving aggregate state', () {
    setUpAll(() {
      defineBookingTypes();
    });

    test('snapshots are not saved eagerly', () async {
      // Arrange
      final storage = BookingStateStorage();
      final name = StreamName('stream');
      final state = storage.newInstance();

      // Act
      await storage.save(name, state);

      // Assert
      expect(storage.contains(name), isFalse);
      expect(storage.hasSnapshot(name), isFalse);
    });

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
      final storage = BookingStateStorage(
        settings: AggregateStateStorageSettings(
          eager: true,
        ),
      );
      final name = StreamName('stream');
      final state = storage.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await storage.save(name, state0);

      // Assert
      expect(storage.contains(name), isFalse);
      expect(storage.hasSnapshot(name), isTrue);
    });

    test('snapshots are saved and cached eagerly', () async {
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
      final storage = BookingStateStorage(
        settings: AggregateStateStorageSettings(
          eager: true,
          useCache: true,
        ),
      );
      final name = StreamName('stream');
      final state = storage.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await storage.save(name, state0);

      // Assert
      expect(storage.contains(name), isTrue);
      expect(storage.hasSnapshot(name), isTrue);
    });

    test('snapshots are not saved for states with version == -1', () async {
      // Arrange
      final storage = BookingStateStorage(
        settings: AggregateStateStorageSettings(
          eager: false,
          threshold: 0,
        ),
      );
      final name = StreamName('stream');

      // State with version == -1
      final state = storage.newInstance();

      // Act
      await storage.save(name, state);

      // Assert
      expect(storage.contains(name), isFalse);
      expect(storage.hasSnapshot(name), isFalse);
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
      final storage = BookingStateStorage(
        settings: AggregateStateStorageSettings(
          eager: false,
          threshold: 0,
          useCache: false,
        ),
      );
      final name = StreamName('stream');

      // State with version == 1
      final state = storage.newInstance();
      final state0 = state.when<RoomBooked, BookingState>(roomBooked);
      final state1 = state0.when<RoomBooked, BookingState>(roomBooked);

      // Act
      await storage.save(name, state1);
      final loaded = await storage.load(name);

      // Assert
      expect(storage.contains(name), isFalse);
      expect(storage.hasSnapshot(name), isTrue);
      expect(loaded, state1);
    });
  });
}
