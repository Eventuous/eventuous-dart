import 'package:eventuous/eventuous.dart';
import 'package:test/test.dart';

import 'harness.dart';

void main() {
  group('When only aggregate types given', () {
    _doAll(TestHarness()
      ..withBookingTypeMaps()
      ..withBookingStore()
      ..install());
  });

  group('When only aggregate state store given', () {
    _doAll(TestHarness()
      ..withBookingStateStore()
      ..withBookingStore()
      ..install());
  });

  group('With both aggregate types and state store is given', () {
    _doAll(TestHarness()
      ..withBookingTypeMaps()
      ..withBookingStateStore()
      ..withBookingStore()
      ..install());
  });
}

void _doAll(TestHarness harness) {
  test('Initial state is empty', () async {
    // Arrange
    final original = Booking.from('is_empty');
    final init = original.current.value;

    // Assert
    expect(init, isEmpty);
  });

  test('Apply completes with state ok', () async {
    // Arrange
    final original = Booking.from('apply_it');
    final event = RoomBooked(roomId: 'value');

    // Act
    final local = original.apply(event);

    // Assert
    expect(
      original.original,
      isA<BookingState>().having(
        (e) => e.roomId,
        'room id',
        isNull,
      ),
    );
    expect(
      original.current,
      isA<BookingState>().having(
        (e) => e.roomId,
        'room id',
        'value',
      ),
    );
    expect(
      local.current,
      isA<BookingState>().having(
        (e) => e.roomId,
        'room id',
        'value',
      ),
    );
  });

  test('Save completes with state ok', () async {
    // Arrange
    final original = Booking.from('save_it');
    final event = RoomBooked(roomId: 'value');
    final local = original.apply(event);

    // Act
    final remote = await harness.bookingStore.save(original);

    // Assert
    expect(
      original.current,
      isA<BookingState>().having(
        (e) => e.roomId,
        'room id',
        'value',
      ),
    );
    expect(
      local.current,
      isA<BookingState>().having(
        (e) => e.roomId,
        'room id',
        'value',
      ),
    );
    expect(
      remote,
      isA<BookingStateOk>().having(
        (result) => result.current,
        'has state ${local.current}',
        equals(local.current),
      ),
    );
  });

  test('Load state fails with aggregate not found', () async {
    // Assert
    expect(
      await harness.bookingStore.loadState(
        BookingId('is_not_found'),
      ),
      isA<BookingState>().having(
        (result) => result.expectedVersion,
        'has no state',
        ExpectedStreamVersion.noStream,
      ),
    );
  });

  test('Load aggregate fails with aggregate not found', () async {
    // Assert
    await expectLater(
      harness.bookingStore.load(
        BookingId('is_not_found'),
      ),
      throwsA(isA<AggregateNotFoundException>().having(
        (result) => result.cause,
        'has failure aggregate not found',
        isA<StreamNotFoundException>(),
      )),
    );
  });

  test('Load completes with state ok', () async {
    // Arrange
    final original = Booking.from('load_it');
    final event = RoomBooked(roomId: 'value');
    final local = original.apply(event);
    await harness.bookingStore.save(original);

    // Act
    final actual = await harness.bookingStore.load(original.id);

    // Assert
    expect(
      actual,
      isA<Booking>().having(
        (e) => e.current.value['roomId'],
        'room id',
        'value',
      ),
    );
    expect(
      local.current,
      isA<BookingState>().having(
        (e) => e.roomId,
        'room id',
        'value',
      ),
    );
    expect(
      original.current,
      isA<BookingState>().having(
        (e) => e.roomId,
        'room id',
        'value',
      ),
    );
  });
}
