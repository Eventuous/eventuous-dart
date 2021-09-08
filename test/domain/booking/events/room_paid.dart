import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_paid.g.dart';

@JsonSerializable()
class RoomPaid extends JsonObject {
  RoomPaid({
    required this.roomId,
  }) : super([roomId]);
  final String roomId;

  /// Factory constructor for creating a new `RoomPaidModel` instance
  factory RoomPaid.fromJson(Map<String, dynamic> json) =>
      _$RoomPaidFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$RoomPaidToJson(this);
}
