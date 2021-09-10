class ExpectedStreamVersion {
  const ExpectedStreamVersion(this.value);

  /// Any stream state is expected
  static const any = ExpectedStreamVersion(-2);

  /// Not stream is expected
  static const noStream = ExpectedStreamVersion(-1);

  /// Get version value
  final int value;

  /// Get stream truncate position from
  StreamTruncatePosition toTruncatePosition([
    int offset = StreamTruncatePosition.Include,
  ]) =>
      StreamTruncatePosition(value);

  @override
  String toString() {
    return '$runtimeType{value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpectedStreamVersion &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class StreamReadPosition {
  const StreamReadPosition(this.value);

  static const start = StreamReadPosition(0);

  final int value;

  @override
  String toString() {
    return '$runtimeType{value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpectedStreamVersion &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class StreamTruncatePosition {
  const StreamTruncatePosition(this.value);

  /// Truncate all events in stream including last event
  static const int Include = 0;

  /// Truncate all events in stream excluding last event
  static const int Exclude = -1;

  /// Get version value
  final int value;

  @override
  String toString() {
    return '$runtimeType{value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpectedStreamVersion &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
