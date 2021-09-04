import 'package:eventuous/eventuous.dart';

class AggregateStateTypeMap {
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};
  static final Map<Type, AggregateStateCreator> _creators =
      <Type, AggregateStateCreator>{};

  static void addType<S, T extends AggregateState<S>>(
    AggregateStateCreator creator, {
    String? name,
  }) {
    final type = typeOf<T>();
    final _name = name ?? type.toString();
    _reverseMap[_name] = type;
    _map[type] = _name;
    _creators[type] = creator;
  }

  /// Create [AggregateState] of [T] from given [value]
  static T create<S, T extends AggregateState<S>>([S? value]) =>
      _creators[typeOf<T>()]!(value) as T;

  /// Create [AggregateState] with type [name] from given [value]
  static T createFromName<S, T extends AggregateState<S>>(
    String name, [
    S? value,
  ]) =>
      _creators[_reverseMap[name]!]!(value) as T;

  static String getTypeName<S, T extends AggregateState<S>>() =>
      _map[typeOf<T>()]!;
  static String getTypeNameFromType(Type type) => _map[type]!;
  static String getTypeNameFromEvent(Event event) => _map[event.runtimeType]!;

  static Type getType(String typeName) => _reverseMap[typeName]!;

  static bool contains<S, T extends AggregateState<S>>() =>
      _map.containsKey(typeOf<T>());

  static bool containsType(Type type) => _map.containsKey(type);
  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}
