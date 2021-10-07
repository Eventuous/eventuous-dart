import '../json/json_typedefs.dart';

class AggregateCommandType {
  const AggregateCommandType(this.aggregate);

  final Type aggregate;

  JsonMap toJson() => {
        'aggregate': aggregate.toString(),
        'annotation': '$AggregateCommandType',
      };
}
