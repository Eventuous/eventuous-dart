class ExpectedStreamVersion {
  const ExpectedStreamVersion(this.value);

  static const any = ExpectedStreamVersion(-2);
  static const noStream = ExpectedStreamVersion(-1);

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
