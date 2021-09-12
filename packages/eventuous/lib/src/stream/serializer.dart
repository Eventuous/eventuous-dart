import 'dart:convert';

import 'package:eventuous/eventuous.dart';

abstract class EventSerializer<TEvent extends Object> {
  String get contentType;

  /// Serialize [event] into data.
  List<int> encode(TEvent event);

  /// Serialize [metadata] into data.
  List<int> encodeMetaData(Metadata event);

  /// Deserialize [data] into a [Event] of given [type]
  TEvent decode(List<int> bytes, String type);
}

class DefaultEventSerializer<TData extends Object, TEvent extends Object>
    extends EventSerializer<TEvent> {
  @override
  String get contentType => 'application/json';

  @override
  List<int> encode(TEvent event) {
    return utf8.encode(json.encode(
      event is JsonObject ? event.toJson() : event,
    ));
  }

  @override
  List<int> encodeMetaData(Metadata data) {
    return utf8.encode(json.encode(data));
  }

  @override
  TEvent decode(List<int> bytes, String eventType) {
    return EventType.create<TData, TEvent>(
      eventType,
      json.decode(utf8.decode(bytes)),
    );
  }
}
