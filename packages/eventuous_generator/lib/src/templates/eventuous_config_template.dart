import 'package:eventuous/eventuous.dart';

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

  List<ApplicationTemplate> get apps =>
      inference.apps.map((e) => e.toApplicationTemplate(inference)).toList();

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toInitializerString());
    return buffer.toString();
  }

  String toInitializerString() {
    return '''GetIt ${config.initializerName}(StreamEventStore eventStore) {
  final getIt = GetIt.instance;
  ${apps.map((a) => config.lazyService ? toRegisterLazySingleton(a) : toRegisterSingleton(a)).join()}
  return getIt;
}''';
  }

  String toRegisterSingleton(ApplicationTemplate a) =>
      '''getIt.registerSingleton<${a.name}>(
  ${toNewAggregateStoreInstanceString(a)},
);
''';

  String toRegisterLazySingleton(ApplicationTemplate a) =>
      '''getIt.registerLazySingleton<${a.name}>(() =>
  ${toNewAggregateStoreInstanceString(a)},
);
''';

  String toNewAggregateStoreInstanceString(ApplicationTemplate a) =>
      '''${a.name}(${a.aggregate}Store(
    eventStore,
    onNew: (id, [state]) => ${a.aggregate}(id, state),
  ))''';
}
