import 'dart:async';

import 'package:eventuous/eventuous.dart';

import '../booking.dart';

class BookingService extends ApplicationServiceBase<JsonMap, JsonObject,
    BookingStateModel, BookingId, BookingState, Booking> {
  BookingService(
    BookingStore store,
  ) : super(store) {
    onNew<BookRoom>(
      (cmd) => BookingId(cmd.bookingId),
      (cmd, booking) => booking.bookRoom(
        cmd.roomId,
        cmd.price,
      ),
    );
    onExisting<RecordPayment>(
      (cmd) => BookingId(cmd.bookingId),
      (cmd, booking) => booking.recordPayment(
        cmd.paymentId,
        cmd.amountPaid,
      ),
    );
    onAny<ImportBooking>(
      (cmd) => BookingId(cmd.bookingId),
      (cmd, booking) => booking.importBooking(
        cmd.roomId,
        cmd.price,
        cmd.importId,
      ),
    );
  }

  FutureOr<BookingResult> bookRoom(String bookingId, String roomId, int price) {
    return handle(BookRoom(
      bookingId,
      roomId,
      price,
    ));
  }

  FutureOr<BookingResult> recordPayment(
    String bookingId,
    String paymentId,
    int amountPaid,
  ) {
    return handle(RecordPayment(
      bookingId,
      paymentId,
      amountPaid,
    ));
  }

  FutureOr<BookingResult> importBooking(
    String bookingId,
    String roomId,
    int price, [
    String? importId,
  ]) {
    return handle(ImportBooking(
      bookingId,
      roomId,
      price,
      importId,
    ));
  }
}
