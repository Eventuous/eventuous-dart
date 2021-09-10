import 'package:eventuous/eventuous.dart';

import 'booking.dart';

typedef BookingStore = AggregateStore<JsonMap, JsonObject, BookingStateModel,
    BookingId, BookingState, Booking>;

typedef BookingResult
    = Result<JsonObject, BookingStateModel, BookingId, BookingState, Booking>;

typedef BookingOk
    = OkResult<JsonObject, BookingStateModel, BookingId, BookingState, Booking>;

typedef BookingError = ErrorResult<JsonObject, BookingStateModel, BookingId,
    BookingState, Booking>;

typedef BookingStateResult = AggregateStateResult<JsonObject, BookingStateModel,
    BookingId, BookingState>;

typedef BookingStateOk
    = AggregateStateOk<JsonObject, BookingStateModel, BookingId, BookingState>;

typedef BookingStateError = AggregateStateError<JsonObject, BookingStateModel,
    BookingId, BookingState>;

typedef BookingStateNoOp = AggregateStateNoOp<JsonObject, BookingStateModel,
    BookingId, BookingState>;
