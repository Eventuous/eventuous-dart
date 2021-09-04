import 'package:eventuate/eventuate.dart';

class DomainEventTypeMap {
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};
  static final Map<Type, EventCreator> _creators = <Type, EventCreator>{};

  static void addType<T extends Event>(
    EventCreator creator, {
    String? name,
  }) {
    final type = typeOf<T>();
    final _name = name ?? type.toString();
    _reverseMap[_name] = type;
    _map[type] = _name;
    _creators[type] = creator;
  }

  /// Create [Event] with type [name] from given [data]
  static Event<T> createFromName<T>(String name, T data) =>
      _creators[_reverseMap[name]!]!(data) as Event<T>;

  /// Create [Event] of [type] from given [data]
  static Event<T> createFromType<T>(Type type, T data) =>
      _creators[type]!(data) as Event<T>;

  static String getTypeName<T extends Event>() => _map[typeOf<T>()]!;
  static String getTypeNameFromType(Type type) => _map[type]!;
  static String getTypeNameFromEvent(Event event) => _map[event.runtimeType]!;

  static Type getType(String typeName) => _reverseMap[typeName]!;

  static bool contains<T extends Event>() => _map.containsKey(typeOf<T>());

  static bool containsType(Type type) => _map.containsKey(type);
  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}
