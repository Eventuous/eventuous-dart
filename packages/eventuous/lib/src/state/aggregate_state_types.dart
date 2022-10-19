import 'package:eventuous/eventuous.dart';

class AggregateStateTypes {
  static final Map<Type, Object> _creators = {};
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};

  static void
      define<TValue extends Object, TState extends AggregateState<TValue>>(
    AggregateStateCreator<TValue, TState> creator, {
    String? name,
  }) {
    final type = typeOf<TState>();
    final actual = name ?? type.toString();
    if (!containsTypeName(actual)) {
      _reverseMap[actual] = type;
      _map[type] = actual;
      _creators[type] = creator;
    }
  }

  /// Create [AggregateState] of [TState] from given [value]
  static TState
      create<TValue extends Object, TState extends AggregateState<TValue>>(
              [TValue? value, int? version]) =>
          (_creators[typeOf<TState>()]!
              as AggregateStateCreator<TValue, TState>)(value, version);

  static bool containsType(Type type) => _map.containsKey(type);

  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}
