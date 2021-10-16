import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'domain/booking/booking.dart';
import 'harness.dart';

void main() {
  group('When using a service', () {
    const Price = 1000;
    const RoomId = 'room-1';
    const ImportId = 'import-1';
    var bookingIndex = 0;
    var paymentIndex = 0;
    String nextBookingId() => 'booking-${++bookingIndex}';
    String nextPaymentId() => 'payment-${++paymentIndex}';
    final harness = TestHarness()
      ..withBookingTypeMaps()
      ..withBookingStore()
      ..withBookingStateStorage()
      ..withBookingService()
      ..install();

    test('operation on new succeeds when not exist', () async {
      // Arrange
      final bookingId = nextBookingId();

      // Act
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );

      // Assert
      expect(roomBooked.isOk, isTrue);
      expect(roomBooked.current?.price, Price);
      expect(roomBooked.current?.roomId, RoomId);
      expect(roomBooked.current?.isFullyPaid, isFalse);
    });

    test('operation on new fails when exists', () async {
      // Arrange
      final bookingId = nextBookingId();
      await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );

      // Act
      final duplicate = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );

      // Assert
      expect(duplicate.isError, isTrue);
      expect(
        duplicate,
        isA<BookingError>().having(
          (e) => e.cause,
          'should exist',
          isA<ConcurrentModificationException>(),
        ),
      );
    });

    test('operation on existing succeeds when exist', () async {
      // Arrange
      final bookingId = nextBookingId();
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );
      expect(roomBooked.isOk, isTrue);

      // Act
      final roomPaid1 = await harness.bookingService.recordPayment(
        bookingId,
        nextPaymentId(),
        Price ~/ 2,
      );
      final roomPaid2 = await harness.bookingService.recordPayment(
        bookingId,
        nextPaymentId(),
        Price ~/ 2,
      );

      final events = await harness.eventStore.readEvents(
        StreamName.from(roomBooked.aggregate!),
        StreamReadPosition.start,
      );

      // Assert
      expect(events.length, 3);
      expect(roomPaid1.isOk, isTrue, reason: '$roomPaid1');
      expect(roomPaid1.current?.price, Price);
      expect(roomPaid1.current?.roomId, RoomId);
      expect(roomPaid1.current?.isFullyPaid, isFalse);

      expect(roomPaid2.isOk, isTrue, reason: '$roomPaid2');
      expect(roomPaid2.current?.price, Price);
      expect(roomPaid2.current?.roomId, RoomId);
      expect(roomPaid2.current?.isFullyPaid, isTrue);
    });

    test('operation on existing fails when not exist', () async {
      // Arrange
      final bookingId = nextBookingId();

      // Act
      final duplicate = await harness.bookingService.recordPayment(
        bookingId,
        nextPaymentId(),
        Price,
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

      // Act
      final roomImported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
      );

      // Assert
      expect(roomImported.isOk, isTrue);
      expect(roomImported.current?.roomId, RoomId);
    });

    test('operation on any state succeeds when exists', () async {
      // Arrange
      final bookingId = nextBookingId();
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );
      expect(roomBooked.isOk, isTrue);

      // Act
      final roomImported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
      );

      // Assert
      expect(roomImported.isOk, isTrue, reason: '$roomImported');
      expect(roomImported.current?.price, Price);
      expect(roomImported.current?.roomId, RoomId);
      expect(roomImported.current?.isFullyPaid, isFalse);
    });

    test('duplicate operation on any state does not mutate', () async {
      // Arrange
      final bookingId = nextBookingId();
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );
      expect(roomBooked.isOk, isTrue);
      final roomImported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
      );
      expect(roomImported.isOk, isTrue, reason: '$roomImported');

      // Act
      final duplicate = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
      );

      // Assert
      expect(duplicate.isNoOp, isTrue, reason: '$duplicate');
    });

    test('operation on deleted stream succeeds', () async {
      // Arrange
      final bookingId = nextBookingId();
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );
      expect(roomBooked.isOk, isTrue, reason: '$roomBooked');
      expect(roomBooked.current?.roomId, RoomId);
      final roomPaid = await harness.bookingService.recordPayment(
        bookingId,
        nextPaymentId(),
        Price,
      );
      expect(roomPaid.isOk, isTrue, reason: '$roomPaid');
      expect(roomPaid.current!.roomId, RoomId);
      final deleted = await harness.bookingService.store.delete(
        roomPaid.aggregate!,
      );
      expect(deleted.isNoOp, isTrue, reason: '$deleted');

      // Act
      final bookingImported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
        ImportId,
      );

      final events = await harness.eventStore.readEvents(
        StreamName.from(roomBooked.aggregate!),
        StreamReadPosition.start,
      );

      // Assert
      expect(events.length, 1);
      expect(bookingImported.isOk, isTrue, reason: '$bookingImported');
    });
  });
}
