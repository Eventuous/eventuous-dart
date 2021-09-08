import 'package:eventuous/eventuous.dart';

import 'booking.dart';

typedef BookingStore = AggregateStore<JsonMap, JsonObject, JsonObject,
    BookingId, BookingState, Booking>;

typedef BookingResult
    = Result<JsonObject, JsonObject, BookingId, BookingState, Booking>;

typedef BookingOk
    = OkResult<JsonObject, JsonObject, BookingId, BookingState, Booking>;

typedef BookingError
    = ErrorResult<JsonObject, JsonObject, BookingId, BookingState, Booking>;

typedef BookingStateResult
    = AggregateStateResult<JsonObject, JsonObject, BookingId, BookingState>;

typedef BookingStateOk
    = AggregateStateOk<JsonObject, JsonObject, BookingId, BookingState>;

typedef BookingStateError
    = AggregateStateError<JsonObject, JsonObject, BookingId, BookingState>;

typedef BookingStateNoOp
    = AggregateStateNoOp<JsonObject, JsonObject, BookingId, BookingState>;
