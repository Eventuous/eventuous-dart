class StreamEvent {
  StreamEvent(
    this.name,
    this.data,
    this.contentType, {
    this.meta = const <int>[],
  });
  final String name;
  final List<int> data;
  final List<int> meta;
  final String contentType;
}
