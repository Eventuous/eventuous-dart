import 'dart:collection';

/// Class representing [Metadata]
class Metadata extends MapBase<String, Object> {
  Metadata({Map<String, Object>? data})
      // ignore: prefer_collection_literals
      : _map = LinkedHashMap.from(data ?? <String, Object>{});

  // Internal representation
  final LinkedHashMap<String, Object> _map;

  @override
  Object? operator [](Object? key) => _map[key];

  @override
  void operator []=(String key, value) {
    _map[key] = value;
  }

  @override
  void clear() => _map.clear();

  @override
  Iterable<String> get keys => _map.keys;

  @override
  Object? remove(Object? key) => _map.remove(key);
}
