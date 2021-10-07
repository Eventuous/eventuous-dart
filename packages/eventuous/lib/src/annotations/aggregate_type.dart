import '../json/json_typedefs.dart';

// TODO: Switch to generic metadata annotations
//  - when https://github.com/dart-lang/language/issues/1297
//    has landed on stable (in beta)

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
        if (id != null) 'id': id?.toString(),
        if (event != null) 'event': event?.toString(),
        if (value != null) 'value': value?.toString(),
        if (state != null) 'state': state?.toString(),
      };
}
