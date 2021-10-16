A library with utilities for testing eventuous

## Usage

A simple usage example for testing :

```dart
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
    server = EventStoreServerSingleNode();
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
    final FooStore = FooStore(
      eventStore,
      // TODO: onNew: (id, [state]) => Foo(id, state),
    );

    // Do some testing here...
  });

  test('test aggregate store with EventStoreDB', () {
    // Create some aggregate store with EventStoreDB event store
    // ignore: unused_local_variable
    final FooStore = FooStore(
      EventStoreDB.parse('esdb://localhost:2113?tls=false'),
      // TODO: onNew: (id, [state]) => Foo(id, state),
    );

    // Do some testing here...
  });
}
```
**The example above is not complete**. You should use
[eventuous_generator][eventuous_generator] to generate your own 
aggregate implementation. 


## Features and bugs
Please file feature requests and bugs at the [issue tracker][tracker].

[Dart Build System]: https://github.com/dart-lang/build
[package:eventuous]: https://pub.dev/packages/eventuous
[tracker]: https://github.com/eventuous/eventuous-dart/issues
[eventuous_generator]: https://pub.dev/packages/eventuous_generator
[example]: https://github.com/eventuous/eventuous-dart/tree/master/example
