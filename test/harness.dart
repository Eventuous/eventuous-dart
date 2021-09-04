import 'package:eventuous/eventuous.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'model/foo.dart';
import 'fakes/memory_event_store.dart';

class TestHarness {
  TestHarness() {
    Logger.root.level = Level.SEVERE;
  }

  late final MemoryEventStore eventStore;
  late final AggregateStateStore<JsonMap, FooState> stateStore;
  late final AggregateStore<JsonMap, FooState, Foo> aggregateStore;

  bool _useTypeMaps = false;
  TestHarness withTypeMaps() {
    _useTypeMaps = true;
    return this;
  }

  bool _useStateStore = false;
  TestHarness withStateStore() {
    _useStateStore = true;
    return this;
  }

  bool _useAggregateStore = false;
  TestHarness withAggregateStore() {
    _useAggregateStore = true;
    return this;
  }

  Stream<LogRecord>? get onRecord => _logger?.onRecord;
  Logger? _logger;

  TestHarness withLogger({
    Level level = Level.SEVERE,
  }) {
    _logger = Logger('$runtimeType');
    Logger.root.level = level;
    onRecord?.listen(print);
    return this;
  }

  void install() {
    setUpAll(() {
      _logger?.info('---setUpAll---');
      // _initHiveDir(hiveDir);
      // Hive.init(hiveDir.path);

      if (_useTypeMaps) {
        addFooTypes();
      } else {
        addFooEventTypes();
      }

      eventStore = MemoryEventStore();

      if (_useStateStore) {
        stateStore = AggregateStateStore<JsonMap, FooState>(
          onNew: ([value]) => FooState(value),
        );
      }
      if (_useAggregateStore) {
        aggregateStore = AggregateStore<JsonMap, FooState, Foo>(
          eventStore,
          onNew: (String id, [state]) => Foo(
            id,
            state as FooState,
          ),
          stateStore: _useStateStore ? stateStore : null,
        );
      }

      _logger?.info('---setUpAll--->ok');
    });

    setUp(() {
      _logger?.info('---setUp---');
      // _initHiveDir(hiveDir);
      _logger?.info('---setUp--->ok');
    });

    tearDown(() {
      _logger?.info('---tearDown---');
      // await Hive.deleteFromDisk();
      // await hiveDir.delete(recursive: true);
      _logger?.info('---tearDown--->ok');
    });

    tearDownAll(() {
      _logger?.info('---tearDownAll---');

      // return await Hive.deleteFromDisk();
      _logger?.info('---tearDownAll--->ok');
    });
  }
}
