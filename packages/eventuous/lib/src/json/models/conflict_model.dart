import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conflict_model.g.dart';

enum ConflictType {
  merge,
  exists,
  deleted,
}

@JsonSerializable()
class ConflictModel extends JsonObject {
  ConflictModel({
    required this.type,
    this.code,
    this.base,
    this.mine,
    this.yours,
    this.error,
    this.paths,
  }) : super([
          type,
          base,
          mine,
          yours,
          error,
        ]);

  final String? code;
  final String? error;
  final ConflictType type;

  /// Paths with conflicts
  final List<String>? paths;

  /// Remote state
  final Map<String, dynamic>? base;

  /// Remote conflicts
  final List<Map<String, dynamic>>? mine;

  /// Local conflicts
  final List<Map<String, dynamic>>? yours;

  /// Factory constructor for creating a new `ConflictModel` instance
  factory ConflictModel.fromJson(Map<String, dynamic> json) =>
      _$ConflictModelFromJson(json);

  /// Declare support for serialization to JSON
  @override
  Map<String, dynamic> toJson() => _$ConflictModelToJson(this);

  bool isCode(Object value) => enumName(value) == code;
}
