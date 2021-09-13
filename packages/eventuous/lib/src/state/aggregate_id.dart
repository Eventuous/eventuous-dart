import 'package:uuid/uuid.dart';

class AggregateId {
  AggregateId([String? value]) : value = value ?? Uuid().v4() {
    if (this.value.isEmpty) {
      throw ArgumentError(
        'Aggregate id $runtimeType can not have empty value',
      );
    }
  }

  final String value;

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
