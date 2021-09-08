import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'fakes/exceptions.dart';
import 'harness.dart';

typedef BookingError
    = ErrorResult<JsonObject, JsonObject, BookingId, BookingState, Booking>;

void main() {
  group('When using a service', () {
    var index = 0;
    const RoomId = 'value';
    String nextBookingId() => 'booking-${++index}';
    final harness = TestHarness()
      ..withBookingTypeMaps()
      ..withBookingStore()
      ..withBookingStateStore()
      ..withBookingService()
      ..install();

    test('operation on new succeeds when not exist', () async {
      // Arrange
      final bookingId = nextBookingId();

      // Act
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
      );

      // Assert
      expect(roomBooked.isOK, isTrue);
      expect(roomBooked.state?.roomId, RoomId);
    });

    test('operation on new fails when exists', () async {
      // Arrange
      final bookingId = nextBookingId();
      await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
      );

      // Act
      final duplicate = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
      );

      // Assert
      expect(duplicate.isError, isTrue);
      expect(
        duplicate,
        isA<BookingError>().having(
          (e) => e.cause,
          'should exist',
          isA<WrongExpectedVersionException>(),
        ),
      );
    });

    test('operation on existing succeeds when exist', () async {
      // Arrange
      final bookingId = nextBookingId();
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
      );
      expect(roomBooked.isOK, isTrue);

      // Act
      final roomPaid = await harness.bookingService.payForRoom(
        bookingId,
        RoomId,
      );

      // Assert
      expect(roomPaid.isOK, isTrue);
      expect(roomPaid.state?.roomId, RoomId);
    });

    test('operation on existing fails when not exist', () async {
      // Arrange
      final bookingId = nextBookingId();

      // Act
      final duplicate = await harness.bookingService.payForRoom(
        bookingId,
        RoomId,
      );

      // Assert
      expect(duplicate.isError, isTrue);
      expect(
        duplicate,
        isA<BookingError>().having(
          (e) => e.cause,
          'should exist',
          isA<AggregateNotFoundException>(),
        ),
      );
    });

    test('operation on any state succeeds when not exists', () async {
      // Arrange
      final bookingId = nextBookingId();
      // final roomBooked = await harness.bookingService.bookRoom(
      //   bookingId,
      //   RoomId,
      // );
      // expect(roomBooked.isOK, isTrue);

      // Act
      final roomImported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
      );

      // Assert
      expect(roomImported.isOK, isTrue);
      expect(roomImported.state?.roomId, RoomId);
    });

    test('operation on any state succeeds when exists', () async {
      // Arrange
      final bookingId = nextBookingId();
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
      );
      expect(roomBooked.isOK, isTrue);

      // Act
      final roomImported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
      );

      // Assert
      expect(roomImported.isOK, isTrue);
      expect(roomImported.state?.roomId, RoomId);
    });

    test('duplicate operation on any state is no-op', () async {
      // Arrange
      final bookingId = nextBookingId();
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
      );
      expect(roomBooked.isOK, isTrue);
      final roomImported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
      );
      expect(roomImported.isOK, isTrue);

      // Act
      final duplicate = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
      );

      // Assert
      expect(duplicate.isNoOp, isTrue);
      expect(duplicate.state?.roomId, RoomId);
    });
  });
}
