import 'package:eventuate/eventuate.dart';

class EventStoreResult {}

class AppendEventsResult extends EventStoreResult {
  AppendEventsResult(this.global, this.next);

  factory AppendEventsResult.from(int global, int expected) =>
      AppendEventsResult(
        StreamReadPosition(global),
        ExpectedStreamVersion(expected),
      );

  final ExpectedStreamVersion next;
  final StreamReadPosition global;
}
