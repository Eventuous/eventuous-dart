class BookRoom {
  BookRoom(this.bookingId, this.roomId);
  final String roomId;
  final String bookingId;
}

class PayForRoom {
  PayForRoom(this.bookingId, this.roomId);
  final String roomId;
  final String bookingId;
}

class ImportBooking {
  ImportBooking(this.bookingId, this.roomId);
  final String roomId;
  final String bookingId;
}
