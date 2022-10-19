// **************************************************************************
// ConfigGenerator
// **************************************************************************

// The following import must be added to library this file is part of.
//
// import 'package:grpc/grpc.dart' as grpc;
//
typedef GrpcServer = grpc.Server;

GetIt _$configureEventuous(StreamEventStore eventStore) {
  final getIt = GetIt.instance;

  getIt.registerSingletonWithDependencies<GrpcServer>(
    () => GrpcServer(
        [getIt<ExampleGrpcQueryService>(), getIt<ExampleGrpcCommandService>()]),
    dependsOn: [ExampleApp],
  );

  getIt.registerLazySingleton<ExampleApp>(
    () => ExampleApp(ExampleStore(
      eventStore,
      onNew: (id, [state]) => Example(id, state),
    )),
  );
  return getIt;
}

Future<void> serveGrpc({required dynamic address, required int port}) {
  return GetIt.instance<GrpcServer>().serve(
    port: port,
    address: address,
  );
}
