import 'dart:convert';

import 'package:eventuate/eventuate.dart';

abstract class EventSerializer<T> {
  String get contentType;

  /// Serialize [event] into data.
  List<int> encode(Event<T> event);

  /// Deserialize [data] into a [Event] of given [type]
  Event<T> decode(List<int> bytes, String type);
}

class DefaultEventSerializer<T> extends EventSerializer<T> {
  @override
  String get contentType => 'application/json';

  @override
  List<int> encode(Event<T> event) {
    return utf8.encode(json.encode(event.data));
  }

  @override
  Event<T> decode(List<int> bytes, String eventType) {
    return DomainEventTypeMap.createFromName<T>(
      eventType,
      json.decode(utf8.decode(bytes)),
    );
  }
}
