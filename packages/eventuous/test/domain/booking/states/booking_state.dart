import 'package:eventuous/eventuous.dart';

import '../booking.dart';

class BookingState extends AggregateState<BookingStateModel> {
  BookingState([
    BookingStateModel? value,
    int? version,
  ]) : super(value ?? BookingStateModel(), version) {
    on<RoomBooked>(patch);
    on<BookingImported>(patch);
    on<BookingPaymentRegistered>(patch);
  }

  String? get roomId => value.roomId;

  String? get importId => value.importId;

  int? get price => value.price;

  int? get amountPaid => value.amountPaid;

  bool get isFullyPaid => value.isFullyPaid;

  BookingState patch(JsonObject event, BookingStateModel state) {
    if (event is BookingPaymentRegistered) {
      return BookingState(
        state.recordPayment(event.paymentId, event.amountPaid),
      );
    }
    return BookingState(BookingStateModel.fromJson(JsonUtils.patch(
      state,
      event,
    )));
  }
}
