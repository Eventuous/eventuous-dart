import 'package:eventuous/eventuous.dart';
import 'package:uuid/uuid.dart';

import 'events/room_booked.dart';
import 'events/booking_payment_registered.dart';
import 'events/booking_imported.dart';
import 'states/booking_state.dart';
import 'states/booking_state_model.dart';

export 'app/booking_commands.dart';
export 'app/booking_service.dart';
export 'booking_typedefs.dart';
export 'events/room_booked.dart';
export 'events/booking_payment_registered.dart';
export 'events/booking_imported.dart';
export 'states/booking_state.dart';
export 'states/booking_state_model.dart';
export 'states/booking_state_model.dart';
export 'states/booking_state_storage.dart';

class BookingId extends AggregateId {
  BookingId([String? id]) : super(id);
}

class Booking
    extends Aggregate<JsonObject, BookingStateModel, BookingId, BookingState> {
  Booking(
    BookingId id, [
    BookingState? state,
  ]) : super(id, state ?? BookingState());

  static Booking from(String id) => Booking(BookingId(id));

  void bookRoom(String roomId, int price) {
    ensureDoesntExists();
    apply(RoomBooked(
      price: price,
      roomId: roomId,
      bookingId: id.value,
    ));
  }

  void recordPayment(String roomId, int amountPaid) {
    ensureExists();
    apply(BookingPaymentRegistered(
      paymentId: roomId,
      bookingId: id.value,
      amountPaid: amountPaid,
    ));
  }

  void importBooking(String roomId, int price, [String? importId]) {
    apply(
      BookingImported(
        price: price,
        roomId: roomId,
        bookingId: id.value,
        importId: importId ?? Uuid().v4(),
      ),
    );
  }

  String? get roomId => current.roomId;
  String? get importId => current.importId;

  int? get price => current.price;
  int? get amountPaid => current.amountPaid;
  bool get isFullyPaid => current.isFullyPaid;
}

void addBookingTypes() {
  AggregateType.addType<JsonObject, JsonObject, BookingId, BookingState,
      Booking>((id, [state]) => Booking(id, state));
  AggregateStateType.addType<BookingStateModel, BookingState>(
    ([value, version]) => BookingState(value, version),
  );
  addBookingEventTypes();
}

void addBookingEventTypes() {
  EventType.addType<JsonMap, RoomBooked>((data) => RoomBooked.fromJson(data));
  EventType.addType<JsonMap, BookingPaymentRegistered>(
      (data) => BookingPaymentRegistered.fromJson(data));
  EventType.addType<JsonMap, BookingImported>(
    (data) => BookingImported.fromJson(data),
  );
}
