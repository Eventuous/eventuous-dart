import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_booked.g.dart';

@JsonSerializable()
class RoomBooked extends JsonObject {
  RoomBooked({
    required this.roomId,
  }) : super([roomId]);
  final String roomId;

  /// Factory constructor for creating a new `RoomBookedModel` instance
  factory RoomBooked.fromJson(Map<String, dynamic> json) =>
      _$RoomBookedFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$RoomBookedToJson(this);
}
