import 'package:equatable/equatable.dart';
import 'package:eventuous/eventuous.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../domain/booking/booking.dart';
import '../fakes/in_memory_event_store.dart';

export '../domain/booking/booking.dart';
export '../fakes/in_memory_event_store.dart';

class TestHarness {
  TestHarness() {
    Logger.root.level = Level.SEVERE;
    EquatableConfig.stringify = true;
  }

  late final StreamEventStore eventStore;
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
        addBookingTypes();
      } else {
        addBookingEventTypes();
      }

      // Setup EventStore instance
      eventStore = use ?? InMemoryEventStore();

      if (_useBookingStateStore) {
        bookingStateStore = BookingStateStore(
          onNew: ([value]) => BookingState(value),
        );
      }
      if (_useBookingStore) {
        bookingStore = BookingStore(
          eventStore,
          onNew: (id, [state]) => Booking(id, state),
          states: _useBookingStateStore ? bookingStateStore : null,
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
