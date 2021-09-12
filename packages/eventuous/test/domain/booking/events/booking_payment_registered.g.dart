// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_payment_registered.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingPaymentRegistered _$BookingPaymentRegisteredFromJson(Map json) =>
    BookingPaymentRegistered(
      bookingId: json['bookingId'] as String,
      paymentId: json['paymentId'] as String,
      amountPaid: json['amountPaid'] as int,
    );

Map<String, dynamic> _$BookingPaymentRegisteredToJson(
        BookingPaymentRegistered instance) =>
    <String, dynamic>{
      'amountPaid': instance.amountPaid,
      'bookingId': instance.bookingId,
      'paymentId': instance.paymentId,
    };
