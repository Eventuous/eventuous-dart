import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/argument_model.dart';
import 'package:source_gen/source_gen.dart';

import 'parameter_model.dart';

class MethodModel extends JsonObject implements ParameterModel {
  MethodModel(this.name, this.arguments) : super([name, arguments]);

  @override
  final String name;

  @override
  String get value => jsonEncode(arguments.map((a) => a.toJson()).toList());

  final List<ArgumentModel> arguments;

  Iterable<ArgumentModel> toArgumentsDeclaration(
      [bool Function(ArgumentModel)? where]) {
    return arguments.where((e) => where == null || where(e));
  }

  String toArgumentsDeclarationString([bool Function(ArgumentModel)? where]) {
    final named = <String>[];
    final optional = <String>[];
    final positional = <String>[];
    for (var arg in toArgumentsDeclaration(where)) {
      if (arg.isNamed) {
        named.add(
          '${arg.isRequired ? 'required ' : ''}${arg.type} ${arg.name}${arg.hasDefaultValueCode ? '=${arg.defaultValueCode}' : ''}',
        );
      } else if (arg.isOptional) {
        optional.add(
          '${arg.isRequired ? 'required ' : ''}${arg.type} ${arg.name}${arg.hasDefaultValueCode ? '=${arg.defaultValueCode}' : ''}',
        );
      } else {
        positional.add('${arg.type} ${arg.name}');
      }
    }
    if (optional.isNotEmpty && named.isNotEmpty) {
      throw InvalidGenerationSourceError(
        'Method $name can not have both optional named and optional positional arguments: \n'
        '- named: $named\n'
        '- positional: $positional\n'
        '- optional positional: $optional\n',
      );
    }

    return [
      ...positional,
      if (named.isNotEmpty) '{${named.join(',')}}',
      if (optional.isNotEmpty) '[${optional.join(',')}]',
    ].join(',');
  }

  String toArgumentsInvocationString({
    Map<String, String> use = const {},
    bool Function(ArgumentModel)? where,
    Map<String, String> names = const {},
  }) {
    final named = <String>[];
    final positional = <String>[];
    for (var arg in toArgumentsDeclaration(where)) {
      if (arg.isNamed) {
        named.add(
          '${names[arg.name] ?? arg.name}: ${use[arg.name] ?? arg.name}',
        );
      } else {
        positional.add('${use[arg.name] ?? arg.name}');
      }
    }
    return [
      ...positional,
      ...named,
    ].join(',');
  }

  /// Create a new `MethodModel` instance from [ConstructorElement]
  factory MethodModel.from(String name, ConstructorElement element) {
    return MethodModel(
        name,
        element.declaration.parameters
            .map((p) => ArgumentModel.from(p))
            .toList());
  }

  /// Factory constructor for creating a new `MethodModel` instance
  factory MethodModel.fromJson(Map<String, dynamic> json) => MethodModel(
        json['name'] as String,
        (jsonDecode(json['value']) as List)
            .map((e) => ArgumentModel.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ))
            .toList(),
      );

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'name': name,
        'value': jsonEncode(arguments.map((a) => a.toJson()).toList()),
      };
}
