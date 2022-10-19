import '../json/json_typedefs.dart';

class GrpcServiceType {
  const GrpcServiceType(this.aggregate);

  final Type aggregate;

  JsonMap toJson() => {'aggregate': '${aggregate.runtimeType}'};
}
