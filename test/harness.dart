import 'package:eventuous/eventuous.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'domain/booking/booking.dart';
import 'fakes/in_memory_event_store.dart';

export 'domain/booking/booking.dart';
export 'fakes/in_memory_event_store.dart';

class TestHarness {
  TestHarness() {
    Logger.root.level = Level.SEVERE;
  }

  late final EventStore eventStore;
  late final BookingStore bookingStore;
  late final BookingService bookingService;
  late final BookingStateStore bookingStateStore;

  bool _useBookingTypeMaps = false;
  TestHarness withBookingTypeMaps() {
    _useBookingTypeMaps = true;
    return this;
  }

  bool _useBookingStateStore = false;
  TestHarness withBookingStateStore() {
    _useBookingStateStore = true;
    return this;
  }

  bool _useBookingStore = false;
  TestHarness withBookingStore() {
    _useBookingStore = true;
    return this;
  }

  bool _useBookingService = false;
  TestHarness withBookingService() {
    _useBookingService = true;
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

  void install([EventStore? store]) {
    setUpAll(() {
      _logger?.info('---setUpAll---');
      // _initHiveDir(hiveDir);
      // Hive.init(hiveDir.path);

      if (_useBookingTypeMaps) {
        addBookingTypes();
      } else {
        addBookingEventTypes();
      }

      eventStore = store ?? InMemoryEventStore();

      if (_useBookingStateStore) {
        bookingStateStore = BookingStateStore(
          onNew: ([value]) => BookingState(value),
        );
      }
      if (_useBookingStore) {
        bookingStore = BookingStore(
          eventStore,
          onNew: (id, [state]) => Booking(id, state),
          stateStore: _useBookingStateStore ? bookingStateStore : null,
          serializer: DefaultEventSerializer<JsonMap, JsonObject>(),
        );
      }
      if (_useBookingService) {
        assert(_useBookingStore);
        bookingService = BookingService(bookingStore);
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
