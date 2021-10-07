/// Code generator for Eventuous
library eventuous_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builders/inference_builder.dart';
import 'src/generators/code_generator.dart';
import 'src/generators/config_generator.dart';

const Header = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target
''';

/// Builds inference data
Builder inferenceBuilder(BuilderOptions options) {
  return InferenceBuilder(options.config);
}

/// Builds code based on annotations and inference data
Builder codeBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [CodeGenerator(options.config)],
    'aggregate',
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
