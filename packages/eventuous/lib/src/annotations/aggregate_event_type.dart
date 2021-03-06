import '../json/json_typedefs.dart';

class AggregateEventType {
  const AggregateEventType(
    this.aggregate, {
    this.data,
  });

  final Type? data;
  final Type aggregate;

  JsonMap toJson() => {
        'aggregate': aggregate.toString(),
        'annotation': '$AggregateEventType',
        if (data != null) 'data': data?.toString(),
      };
}
