// TODO: Switch to generic metadata annotations when https://github.com/dart-lang/language/issues/1297 has landed on stable (in beta)

class AggregateType {
  const AggregateType({
    this.id,
    this.event,
    this.value,
    this.state,
  });

  final Type? id;
  final Type? event;
  final Type? value;
  final Type? state;
}
