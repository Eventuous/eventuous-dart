import 'package:eventuous/eventuous.dart';
import 'package:eventuous/src/json/json_utils.dart';

import 'events/room_booked.dart';
import 'events/room_paid.dart';
import 'events/booking_imported.dart';
import 'states/booking_state_model.dart';

export 'app/booking_commands.dart';
export 'app/booking_service.dart';
export 'booking_typedefs.dart';
export 'events/room_booked.dart';
export 'events/room_paid.dart';
export 'events/booking_imported.dart';
export 'states/booking_state_model.dart';
export 'states/booking_state_model.dart';
export 'states/booking_state_store.dart';

class BookingId extends AggregateId {
  BookingId([String? id]) : super(id);
}

class Booking
    extends Aggregate<JsonObject, JsonObject, BookingId, BookingState> {
  Booking(
    BookingId id, [
    BookingState? state,
  ]) : super(id, state ?? BookingState());

  static Booking from(String id) => Booking(BookingId(id));

  bool get isPaid => changes.whereType<RoomPaid>().isNotEmpty;

  void bookRoom(String roomId) {
    ensureDoesntExists();
    apply(RoomBooked(roomId: roomId));
  }

  void payRoom(String roomId) {
    ensureExists();
    apply(RoomPaid(roomId: roomId));
  }

  void import(String roomId) {
    if (!isPaid) {
      apply(BookingImported(roomId: roomId));
    }
  }
}

void addBookingTypes() {
  AggregateType.addType<JsonObject, JsonObject, BookingId, BookingState,
      Booking>(
    (id, [state]) => Booking(id, state as BookingState),
  );
  AggregateStateType.addType<JsonObject, BookingState>(
    ([value]) => BookingState(value),
  );
  addBookingEventTypes();
}

class BookingState extends AggregateState<JsonObject> {
  BookingState([
    JsonObject? value,
  ]) : super(value ?? JsonObject.empty()) {
    on<RoomBooked>(BookingState.patch);
    on<RoomPaid>(BookingState.patch);
    on<BookingImported>(BookingState.patch);
  }

  String? get roomId => value['roomId'] as String?;

  static BookingState patch(JsonObject next, JsonObject old) {
    return BookingState(BookingStateModel.fromJson(JsonUtils.patch(
      old,
      next,
    )));
  }
}

void addBookingEventTypes() {
  EventType.addType<JsonMap, RoomBooked>((data) => RoomBooked.fromJson(data));
  EventType.addType<JsonMap, RoomPaid>((data) => RoomPaid.fromJson(data));
  EventType.addType<JsonMap, BookingImported>(
    (data) => BookingImported.fromJson(data),
  );
}
