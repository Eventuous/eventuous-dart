import 'package:eventuous/eventuous.dart';

/// Class implementing naming convention for event streams
class StreamName {
  StreamName(this.value);

  /// Get [StreamName] for given [aggregate]
  static StreamName from(Aggregate aggregate) => StreamName(
        '${aggregate.runtimeType.toColonCase()}-${aggregate.id}',
      );

  /// Get [StreamName] for given [type] and [id]
  static StreamName fromId(Type type, AggregateId id) => StreamName(
        '${type.toColonCase()}-$id',
      );

  final String value;

  @override
  String toString() => value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreamName &&
          runtimeType == other.runtimeType &&
          value == other.value;
}
