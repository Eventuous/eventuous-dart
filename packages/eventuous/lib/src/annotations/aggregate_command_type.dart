import '../json/json_typedefs.dart';

class AggregateCommandType {
  const AggregateCommandType(
    this.aggregate, {
    this.data,
  });

  final Type? data;
  final Type aggregate;

  JsonMap toJson() => {
        'aggregate': aggregate.toString(),
        'annotation': '$AggregateCommandType',
        if (data != null) 'data': data?.toString(),
      };
}
