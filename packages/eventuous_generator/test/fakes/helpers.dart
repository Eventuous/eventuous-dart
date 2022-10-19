import 'dart:convert';
import 'dart:io';

import 'package:eventuous_generator/src/helpers.dart';

// inference.json methods

String get exampleInferenceJsonDefaults => toInferenceJsonAsString(
      inferTypes: false,
      annotations: [exampleAnnotationsJsonDefaults],
    );

String get exampleInferenceJsonGiven => toInferenceJsonAsString(
      annotations: [exampleAnnotationsJsonGiven],
    );

String get exampleInferenceJsonInferred => toInferenceJsonAsString(
      annotations: [exampleAnnotationsJsonInferred],
    );

// annotations in inference.json methods

String get exampleAnnotationsJsonDefaults =>
    loadAnnotationsJsonAsString('example', toInference(false, false));

String get exampleAnnotationsJsonInferred =>
    loadAnnotationsJsonAsString('example', toInference(false, true));

String get exampleAnnotationsJsonGiven =>
    loadAnnotationsJsonAsString('example', toInference(true, true));

String loadAnnotationsJsonAsString(
  String library,
  String inference,
) {
  final path = 'test/fakes/inferences/${library}_$inference.json';

  // Use JsonEncoder to remove any formatting
  return JsonEncoder().convert(jsonDecode(File(path).readAsStringSync()));
}

// {{library}}_{{mode}}.dart methods

String get exampleSourceGiven =>
    loadSourceAsString('example', toInference(true, true));

String get exampleSourceInferred =>
    loadSourceAsString('example', toInference(false, true));

String get exampleSourceDefaults =>
    loadSourceAsString('example', toInference(false, false));

String loadSourceAsString(String library, String suffix) {
  final path = 'test/fakes/libraries/${library}_$suffix.dart';
  return File(path).readAsStringSync();
}

// {{library}}_{{method}}.g.dart methods

String get exampleGeneratedSourceGiven =>
    loadGeneratedSourceAsString('example', toInference(true, true));

String get exampleGeneratedSourceInferred =>
    loadGeneratedSourceAsString('example', toInference(false, true));

String get exampleGeneratedSourceDefaults =>
    loadGeneratedSourceAsString('example', toInference(false, false));

String loadGeneratedSourceAsString(String library, String suffix) {
  final path = 'test/fakes/libraries/${library}_$suffix.g.dart';
  return File(path).readAsStringSync();
}

// {{library}}_config_{{case}}.dart methods

String get exampleConfigSourceDefault =>
    loadSourceAsString('example', 'config_default');

String get exampleConfigSourceInitializer =>
    loadSourceAsString('example', 'config_initializer');

String get exampleConfigSourceNotLazy =>
    loadSourceAsString('example', 'config_not_lazy');

// {{library}}_config_{{case}}.g.dart methods

String get exampleConfigGeneratedSourceDefault =>
    loadGeneratedSourceAsString('example', 'config_default');

String get exampleConfigGeneratedSourceInitializer =>
    loadGeneratedSourceAsString('example', 'config_initializer');

String get exampleConfigGeneratedSourceNotLazy =>
    loadGeneratedSourceAsString('example', 'config_not_lazy');

// {{library}}_{{case}}.proto methods

String get exampleProtoDefault => loadProtoAsString('example', 'default');
String get exampleProtoInferred => loadProtoAsString('example', 'inferred');
String get exampleProtoGiven => loadProtoAsString('example', 'given');

String loadProtoAsString(String library, String suffix) {
  final path = 'test/fakes/protos/${library}_$suffix.proto';
  return File(path).readAsStringSync();
}

// Other helper methods

String toInference(bool isGiven, bool isInferred) {
  final inference = 'given:$isGiven|inferred:$isInferred';
  switch (inference) {
    case 'given:false|inferred:false':
      // Types defaults are used
      return 'defaults';
    case 'given:false|inferred:true':
      // Types are inferred from annotations
      return 'inferred';
    case 'given:true|inferred:false':
    case 'given:true|inferred:true':
      // Types in annotations are used
      return 'given';
    default:
      throw ArgumentError('Inference not supported', inference);
  }
}
