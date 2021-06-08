/// A light-weight library for event sourcing with dart
///
library eventuate;

export 'src/aggregate.dart';
export 'src/aggregate_id.dart';
export 'src/aggregate_state.dart';
export 'src/aggregate_store.dart';
export 'src/aggregate_state_store.dart';
export 'src/aggregate_state_type_map.dart';
export 'src/aggregate_type_map.dart';
export 'src/domain_event.dart';
export 'src/event_handler.dart';
export 'src/event_store.dart';
export 'src/domain_event_type_map.dart';
export 'src/exceptions.dart';
export 'src/extensions.dart';
export 'src/serializer.dart';
export 'src/stream_event.dart';
export 'src/stream_name.dart';
export 'src/version.dart';

/// Type helper class
Type typeOf<T>() => T;
