import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_generator/src/builders/models/element_model.dart';
import 'package:eventuous_generator/src/helpers.dart';

import '../../extensions.dart';

class ItemModel extends JsonObject {
  ItemModel(
    this.type,
    this.name,
    this.isNamed,
    this.isRequired,
    this.isPositional,
    this.defaultValueCode,
    this.documentationComment,
    this.archetype,
  ) : super([
          type,
          name,
          isNamed,
          isRequired,
          isPositional,
          defaultValueCode,
          documentationComment,
        ]);

  /// List of Dart types defined as known (not a custom type)
  static const IntrinsicTypes = [
    'Enum',
    'bool',
    'int',
    'Int64',
    'BitInt',
    'double',
    'String',
  ];

  final String type;
  final String name;
  final bool isNamed;
  final bool isRequired;
  final bool isPositional;

  final ElementModel? archetype;
  final String? defaultValueCode;
  final String? documentationComment;

  bool get isOptional => !isRequired;
  bool get isUnsafe => type.endsWith(r'?');
  bool get hasDefaultValueCode => defaultValueCode != null;
  String get unsafeType => type.replaceAll(r'?', '');

  /// Check if [type] is an archetype defined in dart:core
  bool get isIntrinsic => !isExtrinsic;

  /// Check if [type] is an archetype defined outside dart:code
  bool get isExtrinsic => archetype != null;

  ///
  bool get isMap => type.startsWith('Map');
  bool get isSet => type.startsWith('Set');
  bool get isList => type.startsWith('List');
  bool get isIterable => type.startsWith('Iterable');

  /// Create a new `ItemModel` instance from [PropertyAccessorElement]
  factory ItemModel.fromProperty(PropertyAccessorElement element) {
    final type = element.returnType.toTypeName();
    // TODO: Validate property accessor
    return ItemModel(
      type,
      element.displayName.toMemberCase(),
      false,
      false,
      false,
      null,
      toDocumentation(element),
      _toArchetype(type, element.returnType),
    );
  }

  /// Create a new `ItemModel` instance from [ParameterElement]
  factory ItemModel.fromParameter(ParameterElement element) {
    final type = element.type.toTypeName();
    // TODO: Validate constructor
    return ItemModel(
      element.type.toTypeName(),
      element.displayName.toMemberCase(),
      element.isNamed || element.isRequiredNamed || element.isOptionalNamed,
      element.isRequiredPositional || element.isRequiredNamed,
      element.isPositional || element.isRequiredPositional,
      element.defaultValueCode,
      toDocumentation(element),
      _toArchetype(type, element.type),
    );
  }

  /// Factory constructor for creating a new `ItemModel` instance
  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        json['type'] as String,
        json['name'] as String,
        json['isNamed'] as bool,
        json['isRequired'] as bool,
        json['isPositional'] as bool,
        json['defaultValueCode'] as String?,
        json['documentationComment'] as String?,
        json.containsKey('archetype')
            ? ElementModel.fromJson(json['archetype'] as JsonMap)
            : null,
      );

  static ElementModel? _toArchetype(String type, DartType dartType) {
    return !IntrinsicTypes.contains(type.replaceAll(r'?', '')) &&
            dartType.element2 is ClassElement
        ? ElementModel.fromConstructor(
            (dartType.element2 as ClassElement).constructors.first)
        : null;
  }

  /// Declare support for serialization to JSON
  @override
  JsonMap toJson() => {
        'type': type,
        'name': name,
        'isNamed': isNamed,
        'isRequired': isRequired,
        'isPositional': isPositional,
        if (defaultValueCode != null) 'defaultValueCode': defaultValueCode,
        if (archetype != null) 'archetype': archetype!.toJson(),
        if (documentationComment != null)
          'documentationComment': documentationComment,
      };
}
