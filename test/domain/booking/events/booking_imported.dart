import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_imported.g.dart';

@JsonSerializable()
class BookingImported extends JsonObject {
  BookingImported({
    required this.roomId,
  }) : super([roomId]);
  final String roomId;

  /// Factory constructor for creating a new `RoomImportedModel` instance
  factory BookingImported.fromJson(Map<String, dynamic> json) =>
      _$RoomImportedFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$RoomImportedToJson(this);
}
