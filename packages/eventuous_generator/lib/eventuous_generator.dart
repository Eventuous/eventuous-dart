/// Code generator for Eventuous
library eventuous_generator;

import 'package:build/build.dart';
import 'package:eventuous_generator/src/generators/application_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builders/inference_builder.dart';
import 'src/generators/aggregate_generator.dart';
import 'src/generators/config_generator.dart';
import 'src/generators/aggregate_command_generator.dart';
import 'src/generators/aggregate_event_generator.dart';
import 'src/generators/aggregate_state_generator.dart';
import '/src/generators/aggregate_value_generator.dart';

/// Builds inference data
Builder inferenceBuilder(BuilderOptions options) {
  return InferenceBuilder(options.config);
}

/// Builds code based on annotations and inference data
Builder codeBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      AggregateGenerator(options.config),
      ApplicationGenerator(options.config),
      AggregateCommandGenerator(options.config),
      AggregateEventGenerator(options.config),
      AggregateValueGenerator(options.config),
      AggregateStateGenerator(options.config),
    ],
    'aggregate',
    allowSyntaxErrors: true,
  );
}

/// Builds boostrap code for Eventuous configuration
Builder configBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [ConfigGenerator(options.config)],
    'config',
  );
}

/// Deletes temporary inference data
PostProcessBuilder cleanupBuilder(BuilderOptions options) =>
    FileDeletingBuilder(
      const ['.inference.json'],
      isEnabled: options.config['enabled'] as bool? ?? true,
    );
