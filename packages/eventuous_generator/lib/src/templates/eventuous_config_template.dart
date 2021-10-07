import 'package:eventuous/eventuous.dart';

class EventuousConfigTemplate {
  EventuousConfigTemplate({
    required this.config,
  });
  factory EventuousConfigTemplate.from(Eventuous config) {
    return EventuousConfigTemplate(
      config: config,
    );
  }

  final Eventuous config;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toInitializerString());
    return buffer.toString();
  }

  String toInitializerString() {
    return '''
void ${config.initializerName}(GetIt getIt) {
  \$Eventuous.init();
}

typedef EventuousInitCallback = void Function();

class \$Eventuous {
  static final _callbacks = <EventuousInitCallback>{};
  static void init() {
    for (var callback in _callbacks) {
      callback();
    }
  }

  static void onInit(EventuousInitCallback callback) =>
      _callbacks.add(callback);
}''';
  }
}
