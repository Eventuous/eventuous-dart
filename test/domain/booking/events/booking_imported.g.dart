// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_imported.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingImported _$BookingImportedFromJson(Map json) => BookingImported(
      price: json['price'] as int,
      roomId: json['roomId'] as String,
      importId: json['importId'] as String,
      bookingId: json['bookingId'] as String,
    );

Map<String, dynamic> _$BookingImportedToJson(BookingImported instance) =>
    <String, dynamic>{
      'price': instance.price,
      'roomId': instance.roomId,
      'importId': instance.importId,
      'bookingId': instance.bookingId,
    };
