import 'package:uuid/uuid.dart';

class AggregateId {
  AggregateId(this.value) {
    if (value.isEmpty) {
      throw ArgumentError(
        'Aggregate id $runtimeType can not have empty value',
      );
    }
  }
  final String value;

  factory AggregateId.UuidV4() => AggregateId(Uuid().v4());

  @override
  String toString() => value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AggregateId &&
          runtimeType == other.runtimeType &&
          value == other.value;
}
