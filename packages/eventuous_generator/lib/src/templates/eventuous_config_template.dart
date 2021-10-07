import 'package:eventuous/eventuous.dart';

import '../extensions.dart';
import '../builders/models/inference_model.dart';
import 'aggregate_event_template.dart';
import 'aggregate_state_template.dart';
import 'aggregate_template.dart';
import 'aggregate_value_template.dart';

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

  List<AggregateTemplate> get aggregates => inference.aggregates
      .map((e) => e.toAggregateTemplate(e.annotationOf, inference))
      .toList();
  List<AggregateEventTemplate> get events =>
      inference.events.map((e) => e.toAggregateEventTemplate()).toList();
  List<AggregateValueTemplate> get values =>
      inference.values.map((e) => e.toAggregateValueTemplate()).toList();
  List<AggregateStateTemplate> get states => inference.states
      .map((e) => e.toAggregateStateTemplate(inference))
      .toList();

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(toInitializerString());
    return buffer.toString();
  }

  String toInitializerString() {
    return '''void ${config.initializerName}(GetIt getIt) {}''';
  }
}
