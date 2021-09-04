/// A light-weight library for event sourcing with dart
///
library eventuate;

export 'src/aggregate/aggregate.dart';
export 'src/aggregate/aggregate_id.dart';
export 'src/aggregate/aggregate_state.dart';
export 'src/aggregate/aggregate_state_store.dart';
export 'src/aggregate/aggregate_state_type_map.dart';
export 'src/aggregate/aggregate_store.dart';
export 'src/aggregate/aggregate_type_map.dart';
export 'src/events/event.dart';
export 'src/events/event_handler.dart';
export 'src/events/event_store.dart';
export 'src/events/event_store_result.dart';
export 'src/events/event_type_map.dart';
export 'src/events/serializer.dart';
export 'src/events/stream_event.dart';
export 'src/events/stream_name.dart';
export 'src/events/version.dart';
export 'src/exceptions.dart';
export 'src/extensions.dart';

/// Type helper class
Type typeOf<T>() => T;
