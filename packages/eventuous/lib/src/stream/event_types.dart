import 'package:eventuous/eventuous.dart';

class AggregateEventTypes {
  static final Map<Type, Function> _creators = {};
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};

  static void define<TData extends Object, TEvent extends Object>(
    AggregateEventCreator<TData, TEvent> creator, {
    String? name,
  }) {
    final type = typeOf<TEvent>();
    final _name = name ?? type.toString();
    _reverseMap[_name] = type;
    _map[type] = _name;
    _creators[type] = creator;
  }

  /// Create event with given type [name] from given [data]
  static TEvent create<TData extends Object, TEvent extends Object>(
          String name, TData data) =>
      (_creators[_reverseMap[name]!]
          as AggregateEventCreator<TData, TEvent>)(data);

  static String getTypeNameFromEvent(dynamic event) => _map[event.runtimeType]!;

  static bool containsType(Type type) => _map.containsKey(type);

  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}
