import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/annotation_model.dart';
import 'package:eventuous_generator/src/builders/models/element_model.dart';
import 'package:eventuous_generator/src/builders/models/inference_model.dart';
import 'package:eventuous_generator/src/builders/models/item_model.dart';
import 'package:eventuous_generator/src/extensions.dart';
import 'package:eventuous_generator/src/templates/aggregate_command_template.dart';
import 'package:source_gen/source_gen.dart';

import 'api_spec_generator.dart';

class ProtobufGenerator extends ApiSpecGenerator {
  ProtobufGenerator() : super('proto');

  @override
  FutureOr<String> generateApi(
    InferenceModel inference,
    ClassElement element,
    ConstantReader annotation,
  ) {
    final aggregate = annotation.toFieldTypeName('aggregate');
    final app = inference.grpc.firstWhere(
      (e) => e.valueAt('aggregate') == aggregate,
    );
    return _toProto(inference, app);
  }

  String _toProto(InferenceModel inference, AnnotationModel grpc) {
    return '''${_toCommandProto(inference, grpc)}
${_toQueryProto(inference, grpc)}''';
  }

  String _toQueryProto(InferenceModel inference, AnnotationModel grpc) {
    final tId = grpc.valueAt('id');
    final name = grpc.valueAt('aggregate');
    final tState = grpc.valueAt('state');
    final queryIds =
        inference.firstAnnotationOf<AggregateIdType>(name)?.valueAt('query') ==
            'true';
    final queryState = inference
            .firstAnnotationOf<AggregateStateType>(name)
            ?.valueAt('query') ==
        'true';

    return '''service ${name}GrpcQueryService {
  ${[
      queryIds ? _toAggregateIdsQuery(name, tId) : '',
      queryState ? _toAggregateStateQuery(name, tState) : '',
      _toAggregateSubscribeToQuery(name),
    ].where((e) => e.isNotEmpty).join('\n')}
}


// $name id
message ${tId}Event {
  string id = 1;
}

// $name event
message ${name}Event {
  // Field $name id
  string id = 1;
  // Field $name state
  $tState state = 2;
${_toStateModels(inference, grpc, 2)}
}

// Subscribe to events from $name
message SubscribeTo${name}EventsRequest {
  // Subscribe to events
  oneof from {  
    // $name with given id
    string id = 1;        
    // all ${name}s
    google.protobuf.Empty all = 2;
  }
}

${_toStateProto(inference, grpc)}''';
  }

  String _toAggregateIdsQuery(String aggregate, String type) {
    return '''
  // Get stream of ${type}Events
  rpc Get${type}s(google.protobuf.Empty) returns (stream ${type}Event){}''';
  }

  String _toAggregateStateQuery(String aggregate, String type) {
    return '''
  // Get $type for given $aggregate id
  rpc Get$type(${type}Request) returns (${type}Response){}''';
  }

  String _toAggregateSubscribeToQuery(String type) {
    return '''
  // Subscribe to public $type events
  rpc SubscribeTo${type}Events(SubscribeTo${type}EventsRequest) returns (stream ${type}Event){}''';
  }

  String _toCommandProto(InferenceModel inference, AnnotationModel grpc) {
    final name = grpc.valueAt('aggregate');
    final commands =
        inference.annotationsOf<AggregateCommandType>(name).toList();
    return '''service ${name}GrpcCommandService {
${commands.map(_toCommandMethod).join('\n')}
}
${commands.map((e) => e.toAggregateCommandTemplate(inference)).map(_toCommandMessages).join('\n')}''';
  }

  String _toStateProto(InferenceModel inference, AnnotationModel grpc) {
    final tState = grpc.valueAt('state');
    final name = grpc.valueAt('aggregate');

    return '''
// Get $tState request
message ${tState}Request {
  // $name id
  string id = 1;
}

// Get $tState response
message ${tState}Response {

  // Get $tState request result
  oneof result {
    $tState state = 1;
    Error error = 2;
  }

  // Returned on success
${_toStateModels(inference, grpc, 2)}
  
  // Returned on error
  message Error {
    int32 statusCode = 1;
    string reasonPhrase = 2;
  }
}''';
  }

  String _toStateModels(
      InferenceModel inference, AnnotationModel grpc, int padding) {
    final tState = grpc.valueAt('state');
    final name = grpc.valueAt('aggregate');
    final getters = inference
        .annotationsOf<AggregateStateType>(name)
        .map((e) => e.toAggregateStateTemplate(inference))
        .first
        .getters;
    final fields = _toProtoFields(getters, padding + 2);
    final messages = _toProtoMessages(getters, padding + 2);
    final spaces = List.generate(padding, (_) => ' ').join();
    return '''
${spaces}message $tState {
${fields.join('\n')}${messages.isEmpty ? '' : '\n$spaces${messages.join('\n')}'}\n$spaces}''';
  }

  String _toCommandMethod(AnnotationModel command) {
    final name = command.annotationOf;
    return '''  // ${command.documentationComment ?? 'Execute command $name'}
  rpc Execute$name(${name}Request) returns (${name}Response) {}''';
  }

  String _toCommandMessages(AggregateCommandTemplate command) {
    final name = command.name;
    final fields = _toProtoFields(command.getters, 2);
    final messages = _toProtoMessages(command.getters, 2);
    return '''
// Command $name request
message ${name}Request {
${fields.join('\n')}
}
  
// Command $name response
message ${name}Response {
  
  // $name execution result
  oneof result {
    Success success = 1;
    Error error = 2;
  }

  // Returned on success
  message Success {}
  
  // Returned on error
  message Error {
    int32 statusCode = 1;
    string reasonPhrase = 2;
  }${messages.isEmpty ? '' : '\n\n${messages.join('\n\n')}'}
}
''';
  }

  static const Map<String, String> _dartToProtoTypeMap = {
    'Enum': 'enum',
    'bool': 'bool',
    'int': 'Int64',
    'Int64': 'Int64',
    'BitInt': 'Int64',
    'double': 'double',
    'String': 'string',
  };

  List<String> _toProtoFields(ElementModel object, int padding) {
    var field = 0;
    return object.toDeclarationArguments(
      map: (arg) => _toProtoField(arg, ++field, padding),
    );
  }

  String _toProtoField(ItemModel arg, int field, int padding) {
    final dType = arg.unsafeType;
    final pType = _dartToProtoTypeMap[dType] ?? dType;
    final spaces = List.generate(padding, (index) => ' ').join();
    return '''$spaces// ${arg.documentationComment ?? 'Field ${arg.name}'}
$spaces$pType ${arg.name} = $field;''';
  }

  List<String> _toProtoMessages(ElementModel object, int padding) {
    return object.toDeclarationArguments(
      where: (arg) => arg.isExtrinsic,
      map: (arg) => _toProtoMessage(arg, padding),
    );
  }

  String _toProtoMessage(ItemModel arg, int padding) {
    final dType = arg.unsafeType;
    if (_dartToProtoTypeMap.containsKey(dType)) {
      throw InvalidGenerationSourceError(
        'Type $dType is a Dart scalar: ${_dartToProtoTypeMap.keys}',
      );
    }
    final spaces = List.generate(padding, (index) => ' ').join();
    final fields = _toProtoFields(arg.archetype!, padding + 2);
    return '''${spaces}message $dType {
${fields.join('\n')}  
$spaces}''';
  }
}
