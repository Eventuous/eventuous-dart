import 'package:eventuous/eventuous.dart';

class AggregateStateType {
  const AggregateStateType(
    this.aggregate, {
    this.query = false,
  });

  final bool query;
  final Type aggregate;

  JsonMap toJson() => {
        'aggregate': aggregate.toString(),
        'annotation': '$AggregateStateType',
        'query': query,
      };
}
