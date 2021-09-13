import 'package:eventuous/eventuous.dart';

import 'booking.dart';

typedef BookingStore = AggregateStore<JsonMap, JsonObject, BookingStateModel,
    BookingId, BookingState, Booking>;

typedef BookingResult = AggregateCommandResult<JsonObject, BookingStateModel,
    BookingId, BookingState, Booking>;

typedef BookingOk = AggregateCommandOkResult<JsonObject, BookingStateModel,
    BookingId, BookingState, Booking>;

typedef BookingError = AggregateCommandErrorResult<JsonObject,
    BookingStateModel, BookingId, BookingState, Booking>;

typedef BookingStateResult = AggregateStateResult<JsonObject, BookingStateModel,
    BookingId, BookingState>;

typedef BookingStateOk
    = AggregateStateOk<JsonObject, BookingStateModel, BookingId, BookingState>;

typedef BookingStateError = AggregateStateError<JsonObject, BookingStateModel,
    BookingId, BookingState>;

typedef BookingStateNoOp = AggregateStateNoOp<JsonObject, BookingStateModel,
    BookingId, BookingState>;
