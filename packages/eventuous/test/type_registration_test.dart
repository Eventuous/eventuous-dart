import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'domain/booking/booking.dart';

void main() {
  group('When registering types', () {
    setUpAll(() {
      defineBookingTypes();
    });

    test('event types are checkable', () async {
      // Assert
      expect(AggregateEventTypes.containsType(RoomBooked), isTrue);
      expect(AggregateEventTypes.containsTypeName('$RoomBooked'), isTrue);
      expect(
          AggregateEventTypes.containsType(BookingPaymentRegistered), isTrue);
      expect(AggregateEventTypes.containsTypeName('$BookingPaymentRegistered'),
          isTrue);
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
      final roomBooked = AggregateEventTypes.create<JsonMap, RoomBooked>(
        '$RoomBooked',
        data,
      );
      final roomPaid =
          AggregateEventTypes.create<JsonMap, BookingPaymentRegistered>(
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
      expect(AggregateTypes.containsType(Booking), isTrue);
    });

    test('aggregate types are creatable', () async {
      // Arrange
      final data = BookingStateModel.fromJson({'roomId': 'value'});
      // Act
      final booking = AggregateTypes.create<JsonObject, JsonObject, BookingId,
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
      expect(AggregateStateTypes.containsType(BookingState), isTrue);
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
      final state = AggregateStateTypes.create<BookingStateModel, BookingState>(
        BookingStateModel.fromJson(data),
      );

      // Assert
      expect(state, isNotNull);
      expect(state.roomId, 'value');
    });
  });
}
