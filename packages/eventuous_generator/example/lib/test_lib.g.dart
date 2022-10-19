// GENERATED CODE - DO NOT MODIFY BY HAND

part of example;

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
    () => GrpcServer([
      getIt<FooGrpcQueryService>(),
      getIt<FooGrpcCommandService>(),
      getIt<BarGrpcQueryService>(),
      getIt<BarGrpcCommandService>()
    ]),
    dependsOn: [FooApp, BarApp],
  );

  getIt.registerLazySingleton<FooApp>(
    () => FooApp(FooStore(
      eventStore,
      onNew: (id, [state]) => Foo(id, state),
    )),
  );
  getIt.registerLazySingleton<BarApp>(
    () => BarApp(BarStore(
      eventStore,
      onNew: (id, [state]) => Bar(id, state),
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
