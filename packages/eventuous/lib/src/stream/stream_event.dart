class StreamEvent {
  StreamEvent(
    this.eventType,
    this.data,
    this.contentType,
    this.position, {
    this.metadata = const <int>[],
  });

  final int position;
  final List<int> data;
  final String eventType;
  final List<int> metadata;
  final String contentType;
}
