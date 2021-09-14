import 'package:equatable/equatable.dart';

import 'json_typedefs.dart';

abstract class JsonObject extends Equatable {
  /// Construct JsonObject.
  /// Parameter [fields] defines property names
  /// in [toJson]. Use [stringify] to control
  /// [toString] behaviour. @macro equatable_stringify}
  JsonObject(List<Object?> fields, {bool? stringify})
      : _props = [...fields.where((e) => e != null)],
        _stringify = stringify;

  final List<Object?> _props;

  /// @macro equatable_stringify}
  @override
  bool? get stringify => _stringify;
  final bool? _stringify;

  /// Get object as json
  JsonMap toJson();

  /// Get value with [property] name from [toJson]
  Object? operator [](Object? name) => toJson()[name];

  /// Get property names
  Iterable<String> get names => toJson().keys;

  /// {@template equatable_props}
  @override
  List<Object?> get props => _props;

  /// Check if [toJson] is empty (no key/value pairs)
  bool get isEmpty => toJson().isEmpty;

  /// Check if [toJson] is not empty (at least key/value pair)
  bool get isNotEmpty => !isEmpty;

  @override
  String toString() {
    switch (stringify ?? EquatableConfig.stringify) {
      case true:
        return '$runtimeType{${toJson()}}';
      case false:
      default:
        return '$runtimeType';
    }
  }
}
