import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/item_model.dart';
import 'package:eventuous_generator/src/helpers.dart';
import 'package:source_gen/source_gen.dart';

import 'parameter_model.dart';

class ElementModel extends JsonObject implements ParameterModel {
  ElementModel(
    this.name,
    this.items, [
    this.documentationComment,
  ]) : super([name, items, documentationComment]);

  @override
  final String name;

  @override
  final String? documentationComment;

  @override
  String get value => jsonEncode(items.map((a) => a.toJson()).toList());

  final List<ItemModel> items;

  List<String> toDeclarationArguments({
    bool Function(ItemModel)? where,
    String Function(ItemModel)? map,
  }) {
    final named = <String>[];
    final optional = <String>[];
    final positional = <String>[];
    for (var arg in _filter(where)) {
      if (map == null) {
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
      } else {
        positional.add(map(arg));
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
    ];
  }

  String toInvocationArgumentsString({
    bool Function(ItemModel)? where,
    Map<String, String> use = const {},
    Map<String, String> names = const {},
  }) {
    final named = <String>[];
    final positional = <String>[];
    for (var arg in _filter(where)) {
      if (arg.isNamed) {
        named.add(
          '${names[arg.name] ?? arg.name}: ${use[arg.name] ?? arg.name}',
        );
      } else {
        positional.add(use[arg.name] ?? arg.name);
      }
    }
    return [
      ...positional,
      ...named,
    ].join(',');
  }

  List<String> toInvocationGettersString({
    bool Function(ItemModel)? where,
    required String Function(String name) invoke,
  }) {
    final getters = <String>[];
    for (var arg in _filter(where)) {
      getters.add(
        '${arg.type} get ${arg.name} => ${invoke(arg.name)};',
      );
    }
    return getters;
  }

  Iterable<ItemModel> _filter([bool Function(ItemModel)? where]) {
    return items.where((e) => where == null || where(e));
  }

  /// Create a new `ElementModel` instance from [json]
  factory ElementModel.fromJson(JsonMap json) {
    return ElementModel(
      json['name'] as String,
      List.from(jsonDecode(json['value'] as String) as List)
          .map((e) => ItemModel.fromJson(Map.from(e as Map)))
          .toList(),
      json['documentationComment'] as String?,
    );
  }

  /// Create a new `ElementModel` instance from [ClassElement.accessors]
  factory ElementModel.fromGetters(ClassElement element) {
    return ElementModel(
      'getters',
      element.accessors
          .where((e) => e.isGetter && !e.isPrivate)
          .map((g) => ItemModel.fromProperty(g))
          .toList(),
      toDocumentation(element),
    );
  }

  /// Create a new `ElementModel` instance from [ConstructorElement]
  factory ElementModel.fromConstructor(ConstructorElement element) {
    return ElementModel(
      'constructor',
      element.declaration.parameters
          .map((p) => ItemModel.fromParameter(p))
          .toList(),
      toDocumentation(element),
    );
  }

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'name': name,
        'value': jsonEncode(items.map((a) => a.toJson()).toList()),
        if (documentationComment != null)
          'documentationComment': documentationComment,
      };
}
