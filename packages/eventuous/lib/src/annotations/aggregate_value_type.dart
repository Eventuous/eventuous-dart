import 'package:eventuous/eventuous.dart';

class AggregateValueType {
  const AggregateValueType(
    this.aggregate, {
    this.data,
  });

  final Type? data;
  final Type aggregate;

  JsonMap toJson() => {
        'aggregate': aggregate.toString(),
        'annotation': '$AggregateValueType',
        if (data != null) 'data': data?.toString(),
      };
}
