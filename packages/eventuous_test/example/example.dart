import 'package:eventuous/eventuous.dart';
import 'package:eventuous_test/eventuous_test.dart';
import 'package:test/test.dart';

// TODO: Implement your own aggregate store, this is only indicative
typedef FooStore = AggregateStore<
    JsonMap,
    JsonObject,
    JsonObject,
    AggregateId,
    AggregateState<JsonObject>,
    Aggregate<JsonObject, JsonObject, AggregateId, AggregateState<JsonObject>>>;

void main() {
  // Reusable test resources
  late EventStoreServerSingleNode server;

  setUpAll(() {
    server = EventStoreServerSingleNode(EventStoreImage.LTS);
    return server.start();
  });

  tearDownAll(() async {
    await server.stop();
  });

  test('test aggregate store with InMemoryEventStore', () {
    // Create a StreamEventStore using eventuous_test
    final eventStore = InMemoryEventStore();
    // Create some aggregate store with in-memory event store
    // ignore: unused_local_variable
    final fooStore = FooStore(
      eventStore,
      // TODO: onNew: (id, [state]) => Foo(id, state),
    );

    // Do some testing here...
  });

  test('test aggregate store with EventStoreDB', () {
    // Create some aggregate store with EventStoreDB event store
    // ignore: unused_local_variable
    final fooStore = FooStore(
      EventStoreDB.parse('esdb://localhost:2113?tls=false'),
      // TODO: onNew: (id, [state]) => Foo(id, state),
    );

    // Do some testing here...
  });
}
