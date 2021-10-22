A library with utilities for testing eventuous

## Usage

You can test [Eventuous][package:eventuous] with [StreamEventStore][doc:StreamEventStore] running 
in-memory or running as en external process. 

### Testing in-memory
A simple usage example for testing applications without any external processes:

`pubspec.yaml`
```yaml
dev_dependencies:
  
  // Needed for testing Eventuous
  eventuous_test: any
  
```

`main.dart`
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
}
```

### Testing with external process
A simple usage example for testing applications with EventStoreDB locally:

`pubspec.yaml`
```yaml
dev_dependencies:
  
  // Needed for testing Eventuous
  eventuous_test: any
  
  // Needed for testing with EventStoreDB running locally in Docker
  eventstore_client_test: any

```

`main.dart`
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
  late EventStoreStreamsClient client;
  late EventStoreServerSingleNode server;

  setUpAll(() {
    server = EventStoreServerSingleNode();
    client = EventStoreStreamsClient(
      EventStoreClientSettings.parse('esdb://127.0.0.1:2113?tls=false'),
    );
    return server.start();
  });

  tearDownAll(() async {
    await client.shutdown();
    await server.stop();
  });
  
  test('test aggregate store with EventStoreDB', () {
    // Create some aggregate store with EventStoreDB event store
    // ignore: unused_local_variable
    final FooStore = FooStore(
      server,
      // TODO: onNew: (id, [state]) => Foo(id, state),
    );

    // Do some testing here...
  });
}
```

**The examples above are not complete**. You should use
[eventuous_generator][eventuous_generator] to generate your own 
aggregate implementation. 


## Features and bugs
Please file feature requests and bugs at the [issue tracker][tracker].

[Dart Build System]: https://github.com/dart-lang/build
[package:eventuous]: https://pub.dev/packages/eventuous
[tracker]: https://github.com/eventuous/eventuous-dart/issues
[eventuous_generator]: https://pub.dev/packages/eventuous_generator
[example]: https://github.com/eventuous/eventuous-dart/tree/master/example
[doc:StreamEventStore]: https://pub.dev/documentation/eventuous/latest/eventuous/StreamEventStore-class.html
