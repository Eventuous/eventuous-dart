import '../json/json_typedefs.dart';

class AggregateStateType {
  const AggregateStateType(
    this.aggregate, {
    this.value,
  });

  final Type? value;
  final Type aggregate;

  JsonMap toJson() => {
        'aggregate': aggregate.toString(),
        'annotation': '$AggregateStateType',
        if (value != null) 'value': value?.toString(),
      };
}
