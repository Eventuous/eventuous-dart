import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_state_model.g.dart';

@JsonSerializable()
class BookingStateModel extends JsonObject {
  BookingStateModel({
    this.price,
    this.roomId,
    this.importId,
    this.bookingId,
    List<PaymentRecord>? paymentRecords,
  })  : _paymentRecords = paymentRecords?.toList(),
        super([
          price,
          roomId,
          bookingId,
          importId,
          paymentRecords?.toList(),
        ]);

  final int? price;
  final String? roomId;
  final String? importId;
  final String? bookingId;
  final List<PaymentRecord>? _paymentRecords;

  List<PaymentRecord>? get paymentRecords =>
      _paymentRecords == null ? null : List.unmodifiable(_paymentRecords!);

  /// Factory constructor for creating a new `BookingStateModel` instance
  factory BookingStateModel.fromJson(Map<String, dynamic> json) =>
      _$BookingStateModelFromJson(json);

  /// Get total amount paid
  int get amountPaid =>
      paymentRecords?.fold(
          0, (amountPaid, record) => amountPaid! + record.amountPaid) ??
      0;

  /// Test if sum of [paymentRecords] >= [price].
  bool get isFullyPaid => price != null && amountPaid >= price!;

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$BookingStateModelToJson(this);

  BookingStateModel recordPayment(String paymentId, int amountPaid) {
    return BookingStateModel(
      price: price,
      roomId: roomId,
      importId: importId,
      bookingId: bookingId,
      paymentRecords: [
        if (paymentRecords != null) ...paymentRecords!,
        PaymentRecord(paymentId, amountPaid),
      ],
    );
  }
}

@JsonSerializable()
class PaymentRecord extends JsonObject {
  PaymentRecord(
    this.paymentId,
    this.amountPaid,
  ) : super([paymentId, amountPaid]);
  final int amountPaid;
  final String paymentId;

  /// Factory constructor for creating a new `PaymentRecord` instance
  factory PaymentRecord.fromJson(Map<String, dynamic> json) =>
      _$PaymentRecordFromJson(json);

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => _$PaymentRecordToJson(this);
}
