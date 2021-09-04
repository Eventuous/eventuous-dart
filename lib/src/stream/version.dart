class ExpectedStreamVersion {
  const ExpectedStreamVersion(this.value);

  static const any = ExpectedStreamVersion(-2);
  static const noStream = ExpectedStreamVersion(-1);

  final int value;
}

class StreamReadPosition {
  const StreamReadPosition(this.value);

  static const start = StreamReadPosition(0);

  final int value;
}
