import 'package:eventuous_generator/src/generators/protobuf_generator.dart';

import 'api_spec_builder.dart';

class GrpcSpecBuilder extends ApiSpecBuilder {
  GrpcSpecBuilder(
    Map<String, Object?> config,
  ) : super(config, ProtobufGenerator());
}
