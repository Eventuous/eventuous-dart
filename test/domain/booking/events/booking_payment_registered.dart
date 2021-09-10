import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_payment_registered.g.dart';

@JsonSerializable()
class BookingPaymentRegistered extends JsonObject {
  BookingPaymentRegistered({
    required this.bookingId,
    required this.paymentId,
    required this.amountPaid,
  }) : super([bookingId, paymentId, amountPaid]);
  final int amountPaid;
  final String bookingId;
  final String paymentId;

  /// Factory constructor for creating a new `BookingPaymentRegistered` instance
  factory BookingPaymentRegistered.fromJson(Map<String, dynamic> json) =>
      _$BookingPaymentRegisteredFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$BookingPaymentRegisteredToJson(this);
}
