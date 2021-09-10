import 'package:eventuous/eventuous.dart';
import 'package:eventuous/src/json/json_utils.dart';

import '../booking.dart';

class BookingState extends AggregateState<BookingStateModel> {
  BookingState([
    BookingStateModel? value,
  ]) : super(value ?? BookingStateModel()) {
    on<RoomBooked>(BookingState.patch);
    on<BookingImported>(BookingState.patch);
    on<BookingPaymentRegistered>(BookingState.patch);
  }

  String? get roomId => value.roomId;
  String? get importId => value.importId;

  int? get price => value.price;
  int? get amountPaid => value.amountPaid;
  bool get isFullyPaid => value.isFullyPaid;

  static BookingState patch(JsonObject event, BookingStateModel state) {
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
