import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_imported.g.dart';

@JsonSerializable()
class BookingImported extends JsonObject {
  BookingImported({
    required this.price,
    required this.roomId,
    required this.importId,
    required this.bookingId,
  }) : super([price, roomId, importId, bookingId]);
  final int price;
  final String roomId;
  final String importId;
  final String bookingId;

  /// Factory constructor for creating a new `BookingImported` instance
  factory BookingImported.fromJson(Map<String, dynamic> json) =>
      _$BookingImportedFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$BookingImportedToJson(this);
}
