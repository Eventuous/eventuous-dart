import 'dart:async';

import 'package:eventuous/eventuous.dart';

import '../booking.dart';
import 'booking_commands.dart';

class BookingService extends ApplicationServiceBase<JsonMap, JsonObject,
    JsonObject, BookingId, BookingState, Booking> {
  BookingService(
    BookingStore store,
  ) : super(store) {
    OnNew<BookRoom>(
      (cmd) => BookingId(cmd.bookingId),
      (cmd, booking) => booking.bookRoom(cmd.roomId),
    );
    OnExisting<PayForRoom>(
      (cmd) => BookingId(cmd.bookingId),
      (cmd, booking) => booking.payRoom(cmd.roomId),
    );
    OnAny<ImportBooking>(
      (cmd) => BookingId(cmd.bookingId),
      (cmd, booking) => booking.import(cmd.roomId),
    );
  }

  FutureOr<BookingResult> bookRoom(String bookingId, String roomId) {
    return handle(BookRoom(bookingId, roomId));
  }

  FutureOr<BookingResult> payForRoom(String bookingId, String roomId) {
    return handle(PayForRoom(bookingId, roomId));
  }

  FutureOr<BookingResult> importBooking(String bookingId, String roomId) {
    return handle(ImportBooking(bookingId, roomId));
  }
}
