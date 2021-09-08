import 'package:equatable/equatable.dart';

import 'json_typedefs.dart';

abstract class JsonObject extends Equatable {
  JsonObject(List fields) : _props = [...fields];

  static JsonObject empty() => _EmptyJsonObject();

  final List<Object> _props;

  JsonMap toJson();

  /// Get value from given [property]
  Object? operator [](Object? property) => toJson()[property];

  @override
  List<Object> get props => _props;
}

class _EmptyJsonObject extends JsonObject {
  _EmptyJsonObject() : super([]);

  @override
  JsonMap toJson() => {};
  bool get isEmpty => true;
  bool get isNotEmpty => false;
}
