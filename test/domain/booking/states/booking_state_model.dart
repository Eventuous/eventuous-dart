import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_state_model.g.dart';

@JsonSerializable()
class BookingStateModel extends JsonObject {
  BookingStateModel({
    required this.roomId,
  }) : super([roomId]);
  final String roomId;

  /// Factory constructor for creating a new `BookingStateModel` instance
  factory BookingStateModel.fromJson(Map<String, dynamic> json) =>
      _$BookingStateModelFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$BookingStateModelToJson(this);
}
