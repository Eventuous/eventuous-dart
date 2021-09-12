import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'fixtures/esdb/server_single_node.dart';
import 'fixtures/harness.dart';

void main() {
  group('When using a service with eventstore db', () {
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
      ..install<EventStoreServerSingleNode>(
        setup: () async {
          final server = EventStoreServerSingleNode();
          await server.start();
          return server;
        },
        teardown: (server) => server.stop(),
        use: EventStoreDB.parse('esdb://localhost:2113?tls=false'),
      );

    test('operation on new succeeds when not exist', () async {
      // Arrange
      final bookingId = nextBookingId();

      // Act
      final roomBooked = await harness.bookingService.bookRoom(
        bookingId,
        RoomId,
        Price,
      );
      final loaded = await harness.bookingService.store.load(
        BookingId(bookingId),
      );

      // Assert
      expect(roomBooked.isOk, isTrue, reason: '$roomBooked');
      expect(roomBooked.current?.roomId, RoomId);
      expect(loaded.original, roomBooked.current);
      expect(loaded.changes, roomBooked.changes);
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
      expect(duplicate.isError, isTrue, reason: '$duplicate');
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
      expect(roomBooked.isOk, isTrue, reason: '$roomBooked');

      // Act
      final roomPaid = await harness.bookingService.recordPayment(
        bookingId,
        nextPaymentId(),
        Price,
      );
      final loaded = await harness.bookingService.store.load(
        BookingId(bookingId),
      );

      // Assert
      expect(loaded.isFullyPaid, isTrue);
      expect(loaded.original, roomPaid.current);
      expect(loaded.changes, roomPaid.changes);
      expect(roomPaid.isOk, isTrue, reason: '$roomBooked');
      expect(roomPaid.current?.roomId, RoomId);
      expect(roomPaid.aggregate!.isFullyPaid, isTrue);
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
      expect(duplicate.isError, isTrue, reason: '$duplicate');
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
      final imported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
        ImportId,
      );
      final loaded = await harness.bookingService.store.load(
        BookingId(bookingId),
      );

      // Assert
      expect(imported.isOk, isTrue, reason: '$imported');
      expect(imported.current?.roomId, RoomId);
      expect(imported.current?.importId, ImportId);
      expect(loaded.original, imported.current);
      expect(loaded.changes, imported.changes);
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
      expect(roomBooked.current?.roomId, RoomId);

      // Act
      final imported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
        ImportId,
      );
      expect(imported.current?.importId, ImportId);
      final loaded = await harness.bookingService.store.load(
        BookingId(bookingId),
      );

      // Assert
      expect(imported.isOk, isTrue, reason: '$imported');
      expect(imported.current?.roomId, RoomId);
      expect(imported.current?.importId, ImportId);
      expect(loaded.original, imported.current);
      expect(loaded.changes, imported.changes);
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
      expect(roomBooked.current?.roomId, RoomId);
      final imported = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
        ImportId,
      );
      expect(imported.isOk, isTrue);
      expect(imported.current?.importId, ImportId);

      // Act
      final duplicate = await harness.bookingService.importBooking(
        bookingId,
        RoomId,
        Price,
        ImportId,
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
