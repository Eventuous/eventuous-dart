import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/templates/grpc_service_template.dart';

import '../extensions.dart';
import '../builders/models/inference_model.dart';
import 'application_template.dart';

class EventuousConfigTemplate {
  EventuousConfigTemplate({
    required this.config,
    required this.inference,
  });
  factory EventuousConfigTemplate.from(
    Eventuous config,
    InferenceModel inference,
  ) {
    return EventuousConfigTemplate(
      config: config,
      inference: inference,
    );
  }

  final Eventuous config;
  final InferenceModel inference;

  List<GrpcServiceTemplate> get grpc =>
      inference.grpc.map((e) => e.toGrpcServiceTemplate(inference)).toList();

  List<ApplicationTemplate> get apps =>
      inference.apps.map((e) => e.toApplicationTemplate(inference)).toList();

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toInitializerString());
    return buffer.toString();
  }

  String toInitializerString() {
    return '''${grpc.isNotEmpty ? '''
// The following import must be added to library this file is part of.
// 
// import 'package:grpc/grpc.dart' as grpc; 
//
typedef GrpcServer = grpc.Server;''' : ''}

GetIt ${config.initializerName}(StreamEventStore eventStore) {
  final getIt = GetIt.instance;
  
  ${toRegisterGrpcSingletonWithDependencies(grpc, apps)}
  
  ${apps.map((a) => config.lazyService ? toRegisterApplicationLazySingleton(a) : toRegisterApplicationSingleton(a)).join()}
  return getIt;
}
${_toServeGrpc(grpc)}
''';
  }

  String toRegisterApplicationSingleton(ApplicationTemplate a) =>
      '''getIt.registerSingleton<${a.name}>(
  ${toNewAggregateStoreInstanceString(a)},
);''';

  String toRegisterApplicationLazySingleton(ApplicationTemplate a) =>
      '''getIt.registerLazySingleton<${a.name}>(() =>
  ${toNewAggregateStoreInstanceString(a)},
);''';

  String toNewAggregateStoreInstanceString(ApplicationTemplate a) =>
      '''${a.name}(${a.aggregate}Store(
    eventStore,
    onNew: (id, [state]) => ${a.aggregate}(id, state),
  ))''';

  String toRegisterGrpcSingletonWithDependencies(
    Iterable<GrpcServiceTemplate> grpc,
    Iterable<ApplicationTemplate> apps,
  ) =>
      '''getIt.registerSingletonWithDependencies<GrpcServer>(
  ${toNewGrpcService(grpc, apps)}
);''';

  String toNewGrpcService(
    Iterable<GrpcServiceTemplate> grpc,
    Iterable<ApplicationTemplate> apps,
  ) {
    final dependsOn = grpc.map((g) => g.aggregate);
    return '''
  () => GrpcServer([${grpc.map((g) => 'getIt<${g.name}>()').join(',')}]),
  dependsOn: [${apps.where((a) => dependsOn.contains(a.aggregate)).map((a) => a.name).join(',')}],
''';
  }

  String _toServeGrpc(List<GrpcServiceTemplate> grpc) {
    return grpc.isEmpty
        ? ''
        : '''
  Future<void> serveGrpc({required dynamic address, required int port}) {
    return GetIt.instance<GrpcServer>().serve(port: port, address: address,);
  }
''';
  }
}
