import 'package:eventuate/eventuate.dart';

class DomainEventTypeMap {
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};
  static final Map<Type, DomainEventCreator> _creators =
      <Type, DomainEventCreator>{};

  static void addType<T extends DomainEvent>(
    DomainEventCreator creator, {
    String? name,
  }) {
    final type = typeOf<T>();
    final _name = name ?? type.toString();
    _reverseMap[_name] = type;
    _map[type] = _name;
    _creators[type] = creator;
  }

  /// Create [DomainEvent] with type [name] from given [data]
  static DomainEvent<T> createFromName<T>(String name, T data) =>
      _creators[_reverseMap[name]!]!(data) as DomainEvent<T>;

  /// Create [DomainEvent] of [type] from given [data]
  static DomainEvent<T> createFromType<T>(Type type, T data) =>
      _creators[type]!(data) as DomainEvent<T>;

  static String getTypeName<T extends DomainEvent>() => _map[typeOf<T>()]!;
  static String getTypeNameFromType(Type type) => _map[type]!;
  static String getTypeNameFromEvent(DomainEvent event) =>
      _map[event.runtimeType]!;

  static Type getType(String typeName) => _reverseMap[typeName]!;

  static bool contains<T extends DomainEvent>() =>
      _map.containsKey(typeOf<T>());

  static bool containsType(Type type) => _map.containsKey(type);
  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}
