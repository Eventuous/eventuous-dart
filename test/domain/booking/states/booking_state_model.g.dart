// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingStateModel _$BookingStateModelFromJson(Map json) => BookingStateModel(
      price: json['price'] as int?,
      roomId: json['roomId'] as String?,
      importId: json['importId'] as String?,
      bookingId: json['bookingId'] as String?,
      paymentRecords: (json['paymentRecords'] as List<dynamic>?)
          ?.map((e) =>
              PaymentRecord.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$BookingStateModelToJson(BookingStateModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('price', instance.price);
  writeNotNull('roomId', instance.roomId);
  writeNotNull('importId', instance.importId);
  writeNotNull('bookingId', instance.bookingId);
  writeNotNull('paymentRecords',
      instance.paymentRecords?.map((e) => e.toJson()).toList());
  return val;
}

PaymentRecord _$PaymentRecordFromJson(Map json) => PaymentRecord(
      json['paymentId'] as String,
      json['amountPaid'] as int,
    );

Map<String, dynamic> _$PaymentRecordToJson(PaymentRecord instance) =>
    <String, dynamic>{
      'amountPaid': instance.amountPaid,
      'paymentId': instance.paymentId,
    };
