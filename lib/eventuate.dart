/// A light-weight library for event sourcing with dart
///
library eventuate;

export 'src/state/aggregate.dart';
export 'src/state/aggregate_id.dart';
export 'src/state/aggregate_state.dart';
export 'src/state/aggregate_state_store.dart';
export 'src/state/aggregate_state_type_map.dart';
export 'src/state/aggregate_store.dart';
export 'src/state/aggregate_type_map.dart';
export 'src/stream/event.dart';
export 'src/stream/event_handler.dart';
export 'src/stream/event_store.dart';
export 'src/stream/event_store_result.dart';
export 'src/stream/event_type_map.dart';
export 'src/stream/serializer.dart';
export 'src/stream/stream_event.dart';
export 'src/stream/stream_name.dart';
export 'src/stream/version.dart';
export 'src/exceptions.dart';
export 'src/extensions.dart';

/// Type helper class
Type typeOf<T>() => T;
