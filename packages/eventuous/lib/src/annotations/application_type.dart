import '../json/json_typedefs.dart';

class ApplicationType {
  const ApplicationType(this.aggregate);

  final Type aggregate;

  JsonMap toJson() => {'aggregate': '${aggregate.runtimeType}'};
}
