import 'package:eventuous/eventuous.dart';

class AggregateIdType {
  const AggregateIdType(
    this.aggregate, {
    this.query = false,
  });

  final bool query;
  final Type aggregate;

  JsonMap toJson() => {
        'aggregate': '${aggregate.runtimeType}',
        'query': query,
      };
}
