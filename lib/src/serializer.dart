import 'dart:convert';

import 'package:eventuate/src/domain_event_type_map.dart';

import 'domain_event.dart';

abstract class EventSerializer<T> {
  String get contentType;

  /// Serialize [event] into data.
  List<int> encode(DomainEvent<T> event);

  /// Deserialize [data] into a [DomainEvent] of given [type]
  DomainEvent<T> decode(List<int> bytes, String type);
}

class DefaultEventSerializer<T> extends EventSerializer<T> {
  @override
  String get contentType => 'application/json';

  @override
  List<int> encode(DomainEvent<T> event) {
    return utf8.encode(json.encode(event.data));
  }

  @override
  DomainEvent<T> decode(List<int> bytes, String eventType) {
    return DomainEventTypeMap.createFromName<T>(
      eventType,
      json.decode(utf8.decode(bytes)),
    );
  }
}
