import '../json/json_typedefs.dart';

class AggregateType {
  const AggregateType({
    required this.id,
    required this.event,
    required this.value,
    required this.state,
  });

  final Type? id;
  final Type? event;
  final Type? value;
  final Type? state;

  JsonMap toJson(String aggregate) => {
        'aggregate': aggregate,
        'annotation': '$AggregateType',
        'id': id?.toString(),
        'event': event?.toString(),
        'value': value?.toString(),
        'state': state?.toString(),
      };
}
