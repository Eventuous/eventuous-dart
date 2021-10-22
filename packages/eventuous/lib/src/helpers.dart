/// Type helper class
Type typeOf<TAggregate>() => TAggregate;

/// Get enum value name
String enumName(Object o) => o.toString().split('.').last;

extension MapX<K, V> on Map<K, V> {
  /// Check if map contains data at given path
  bool hasPath(String ref) => elementAt(ref) != null;

  /// Get element with given reference on format '/name1/name2/name3'
  /// equivalent to map['name1']['name2']['name3'].
  ///
  /// Returns [null] if not found
  TAggregate? elementAt<TAggregate>(String path, {TAggregate? defaultValue}) {
    final parts = path.split('/');
    dynamic found =
        parts.skip(parts.first.isEmpty ? 1 : 0).fold(this, (parent, name) {
      if (parent is Map<String, dynamic>) {
        if (parent.containsKey(name)) {
          return parent[name];
        }
      }
      final element = (parent ?? {});
      return element is Map
          ? element[name]
          : element is List && element.isNotEmpty
              ? element[int.parse(name)]
              : defaultValue;
    });
    return (found ?? defaultValue) as TAggregate?;
  }

  /// Get [List] of type [TAggregate] at given path
  List<TAggregate>? listAt<TAggregate>(String path,
      {List<TAggregate>? defaultList}) {
    final list = elementAt(path);
    return list == null ? defaultList : List<TAggregate>.from(list as List);
  }

  /// Get [Map] with keys of type [TState] and values of type [TAggregate] at given path
  Map<TState, TAggregate>? mapAt<TState, TAggregate>(String path,
      {Map<TState, TAggregate>? defaultMap}) {
    final map = elementAt(path);
    return map == null ? defaultMap : Map<TState, TAggregate>.from(map as Map);
  }
}
