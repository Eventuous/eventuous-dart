import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'fixtures/harness.dart';

void main() {
  group('When registering types', () {
    setUpAll(() {
      addBookingTypes();
    });

    test('event types are checkable', () async {
      // Assert
      expect(EventType.containsType(RoomBooked), isTrue);
      expect(EventType.containsTypeName('$RoomBooked'), isTrue);
      expect(EventType.containsType(BookingPaymentRegistered), isTrue);
      expect(EventType.containsTypeName('$BookingPaymentRegistered'), isTrue);
    });

    test('event types are creatable', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'amountPaid': 1000,
        'paymentId': 'value',
        'bookingId': 'value',
      };
      // Act
      final roomBooked = EventType.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final roomPaid = EventType.create<JsonMap, BookingPaymentRegistered>(
        '$BookingPaymentRegistered',
        data,
      );

      // Assert
      expect(roomBooked, isNotNull);
      expect(roomBooked.roomId, 'value');
      expect(roomPaid, isNotNull);
      expect(roomPaid.paymentId, 'value');
    });

    test('aggregate types are checkable', () async {
      // Assert
      expect(AggregateType.containsType(Booking), isTrue);
    });

    test('aggregate types are creatable', () async {
      // Arrange
      final data = BookingStateModel.fromJson({'roomId': 'value'});
      // Act
      final booking = AggregateType.create<JsonObject, JsonObject, BookingId,
          BookingState, Booking>(
        BookingId('$RoomBooked'),
        BookingState(data),
      );

      // Assert
      expect(booking, isNotNull);
      expect(booking.current.roomId, 'value');
      expect(booking.original.roomId, 'value');
    });

    test('aggregate state types are checkable', () async {
      // Assert
      expect(AggregateStateType.containsType(BookingState), isTrue);
    });

    test('aggregate state types are creatable', () async {
      // Arrange
      final data = {
        'price': 1000,
        'roomId': 'value',
        'amountPaid': 1000,
        'paymentId': 'value',
        'bookingId': 'value',
      };

      // Act
      final state = AggregateStateType.create<BookingStateModel, BookingState>(
        BookingStateModel.fromJson(data),
      );

      // Assert
      expect(state, isNotNull);
      expect(state.roomId, 'value');
    });
  });
}
