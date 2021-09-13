class BookRoom {
  BookRoom(this.bookingId, this.roomId, this.price);

  final int price;
  final String roomId;
  final String bookingId;
}

class RecordPayment {
  RecordPayment(this.bookingId, this.paymentId, this.amountPaid);

  final int amountPaid;
  final String paymentId;
  final String bookingId;
}

class ImportBooking {
  ImportBooking(this.bookingId, this.roomId, this.price, [this.importId]);

  final int price;
  final String roomId;
  final String? importId;
  final String bookingId;
}
