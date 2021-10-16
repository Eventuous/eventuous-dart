import 'package:equatable/equatable.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_test/eventuous_test.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'domain/booking/booking.dart';

class TestHarness {
  TestHarness() {
    Logger.root.level = Level.SEVERE;
    EquatableConfig.stringify = true;
  }

  late final BookingStore bookingStore;
  late final StreamEventStore eventStore;
  late final BookingService bookingService;
  late final BookingStateStorage bookingStateStorage;

  bool _useBookingTypeMaps = false;

  TestHarness withBookingTypeMaps() {
    _useBookingTypeMaps = true;
    return this;
  }

  bool _useBookingStateStorage = false;

  TestHarness withBookingStateStorage() {
    _useBookingStateStorage = true;
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

  void install<T>({
    StreamEventStore? use,
    Future<T> Function()? setup,
    Future<void> Function(T)? teardown,
  }) {
    late T ref;
    setUpAll(() async {
      _logger?.info('---setUpAll---');

      if (setup != null) {
        ref = await setup.call();
      }

      if (_useBookingTypeMaps) {
        defineBookingTypes();
      } else {
        defineBookingEventTypes();
      }

      // Setup EventStore instance
      eventStore = use ?? InMemoryEventStore();

      if (_useBookingStateStorage) {
        bookingStateStorage = BookingStateStorage(
          onNew: ([value, version]) => BookingState(value, version),
        );
      }
      if (_useBookingStore) {
        bookingStore = BookingStore(
          eventStore,
          onNew: (id, [state]) => Booking(id, state),
          states: _useBookingStateStorage ? bookingStateStorage : null,
          serializer: DefaultEventSerializer<JsonMap, JsonObject>(),
        );
      }
      if (_useBookingService) {
        assert(_useBookingStore);
        bookingService = BookingService(bookingStore);
      }

      _logger?.info('---setUpAll--->ok');
    });

    if (teardown != null) {
      tearDownAll(() async {
        return teardown(ref);
      });
    }
  }
}
