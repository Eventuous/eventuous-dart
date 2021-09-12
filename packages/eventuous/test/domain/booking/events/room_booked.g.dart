// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_booked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomBooked _$RoomBookedFromJson(Map json) => RoomBooked(
      price: json['price'] as int,
      roomId: json['roomId'] as String,
      bookingId: json['bookingId'] as String,
    );

Map<String, dynamic> _$RoomBookedToJson(RoomBooked instance) =>
    <String, dynamic>{
      'price': instance.price,
      'roomId': instance.roomId,
      'bookingId': instance.bookingId,
    };
