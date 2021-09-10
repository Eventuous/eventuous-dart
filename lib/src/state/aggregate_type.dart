import 'package:eventuous/eventuous.dart';

class AggregateType {
  static final Map<Type, Object> _creators = {};
  static final Map<Type, String> _map = <Type, String>{};
  static final Map<String, Type> _reverseMap = <String, Type>{};

  static void addType<
      TEvent extends Object,
      TValue extends Object,
      TId extends AggregateId,
      TState extends AggregateState<TValue>,
      TAggregate extends Aggregate<TEvent, TValue, TId, TState>>(
    AggregateCreator<TEvent, TValue, TId, TState, TAggregate> creator, {
    String? name,
  }) {
    final type = typeOf<TAggregate>();
    final _name = name ?? type.toString();
    _reverseMap[_name] = type;
    _map[type] = _name;
    _creators[type] = creator;
  }

  /// Create [Aggregate] of [type] from given [data]
  static TAggregate create<
              TEvent extends Object,
              TValue extends Object,
              TId extends AggregateId,
              TState extends AggregateState<TValue>,
              TAggregate extends Aggregate<TEvent, TValue, TId, TState>>(TId id,
          [TState? state]) =>
      (_creators[typeOf<TAggregate>()]
              as AggregateCreator<TEvent, TValue, TId, TState, TAggregate>)(
          id, state);

  static bool containsType(Type type) => _map.containsKey(type);
  static bool containsTypeName(String name) => _reverseMap.containsKey(name);
}