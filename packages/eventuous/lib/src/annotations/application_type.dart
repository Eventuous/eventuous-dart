import 'package:eventuous/eventuous.dart';

class ApplicationType {
  const ApplicationType(this.aggregate);

  final Type aggregate;

  JsonMap toJson() => {'aggregate': '${aggregate.runtimeType}'};
}
