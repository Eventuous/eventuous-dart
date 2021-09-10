import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_fully_paid.g.dart';

@JsonSerializable()
class BookingFullyPaid extends JsonObject {
  BookingFullyPaid({
    required this.bookingId,
  }) : super([bookingId]);

  final String bookingId;

  /// Factory constructor for creating a new `BookingFullyPaid` instance
  factory BookingFullyPaid.fromJson(Map<String, dynamic> json) =>
      _$BookingFullyPaidFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$BookingFullyPaidToJson(this);
}
