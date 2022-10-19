import 'package:eventuous/eventuous.dart';

class GrpcServiceType {
  const GrpcServiceType(this.aggregate);

  final Type aggregate;

  JsonMap toJson() => {'aggregate': '${aggregate.runtimeType}'};
}
