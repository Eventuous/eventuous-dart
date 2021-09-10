import 'package:eventuous/eventuous.dart';

class EventStoreResult {}

class AppendEventsResult extends EventStoreResult {
  AppendEventsResult._(this.name);
  final StreamName name;

  factory AppendEventsResult.ok(StreamName name, int global, int expected) =>
      AppendEventsOk(
        name,
        StreamReadPosition(global),
        ExpectedStreamVersion(expected),
      );

  factory AppendEventsResult.error(
    StreamName name,
    int expected,
    Object cause,
  ) =>
      AppendEventsError(
        name,
        ExpectedStreamVersion(expected),
        cause,
      );

  bool get isOk => this is AppendEventsOk;
  bool get isError => this is AppendEventsError;
}

class AppendEventsOk extends AppendEventsResult {
  AppendEventsOk(StreamName name, this.global, this.expected) : super._(name);

  final StreamReadPosition global;
  final ExpectedStreamVersion expected;
}

class AppendEventsError extends AppendEventsResult {
  AppendEventsError(StreamName name, this.expectedVersion, this.cause)
      : super._(name);
  final Object cause;
  final ExpectedStreamVersion expectedVersion;
}

class WrongExpectedVersionResult extends AppendEventsError {
  WrongExpectedVersionResult(
    StreamName name,
    ExpectedStreamVersion expectedVersion,
    this.actualVersion, [
    Object? cause,
  ]) : super(
          name,
          expectedVersion,
          ConcurrentModificationException(
            name,
            expectedVersion,
            actualVersion,
            cause,
          ),
        );
  final ExpectedStreamVersion actualVersion;
}
