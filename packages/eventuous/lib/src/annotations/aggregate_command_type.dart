import 'package:eventuous/eventuous.dart';

class AggregateCommandType {
  const AggregateCommandType(
    this.aggregate,
    this.event, {
    this.data,
    this.expected = ExpectedState.any,
  });

  final Type? data;
  final Type event;
  final Type aggregate;
  final ExpectedState expected;

  JsonMap toJson() => {
        'event': event.toString(),
        'expected': enumName(expected),
        'aggregate': aggregate.toString(),
        'annotation': '$AggregateCommandType',
        if (data != null) 'data': data?.toString(),
      };
}
