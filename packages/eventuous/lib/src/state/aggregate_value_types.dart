import 'package:eventuous/eventuous.dart';

class AggregateValueTypes {
  static final Map<Type, Object> _creators = {};
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};

  static void define<TData extends Object, TValue extends Object>(
    AggregateValueCreator<TData, TValue> creator, {
    String? name,
  }) {
    final type = typeOf<TValue>();
    final _name = name ?? type.toString();
    if (!containsTypeName(_name)) {
      _reverseMap[_name] = type;
      _map[type] = _name;
      _creators[type] = creator;
    }
  }

  /// Create aggregate state value of [TValue] from given [data]
  static TValue create<TData extends Object, TValue extends Object>(
          [TData? data]) =>
      (_creators[typeOf<TValue>()]!
          as AggregateValueCreator<TData, TValue>)(data);

  static bool containsType(Type type) => _map.containsKey(type);

  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}
