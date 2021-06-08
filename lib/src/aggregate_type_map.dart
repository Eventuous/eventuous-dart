import 'package:eventuate/eventuate.dart';

class AggregateTypeMap {
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};
  static final Map<Type, AggregateCreator> _creators =
      <Type, AggregateCreator>{};

  static void addType<S, T extends Aggregate<S>>(
    AggregateCreator creator, {
    String? name,
  }) {
    final type = typeOf<T>();
    final _name = name ?? type.toString();
    _reverseMap[_name] = type;
    _map[type] = _name;
    _creators[type] = creator;
  }

  /// Create [DomainEvent] with type [name] from given [data]
  static T createFromName<S, T extends Aggregate<S>>(
    String name,
    String id, [
    AggregateState<S>? state,
  ]) =>
      _creators[_reverseMap[name]!]!(id, state) as T;

  /// Create [DomainEvent] of [type] from given [data]
  static T create<S, T extends Aggregate<S>>(
    String id, [
    AggregateState<S>? state,
  ]) =>
      _creators[typeOf<T>()]!(id, state) as T;

  static String getTypeName<S, T extends Aggregate<S>>() => _map[typeOf<T>()]!;
  static String getTypeNameFromType(Type type) => _map[type]!;
  static String getTypeNameFromEvent(DomainEvent event) =>
      _map[event.runtimeType]!;

  static Type getType(String typeName) => _reverseMap[typeName]!;

  static bool contains<S, T extends Aggregate<S>>() =>
      _map.containsKey(typeOf<T>());

  static bool containsType(Type type) => _map.containsKey(type);
  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}
