import 'package:eventuous/eventuous.dart';

import '../booking.dart';

class BookingStateStore
    extends AggregateStateStorage<BookingStateModel, BookingState> {
  BookingStateStore({
    AggregateStateCreator<BookingStateModel, BookingState>? onNew,
    AggregateStateStorageSettings settings =
        AggregateStateStorageSettings.Default,
  }) : super(onNew: onNew, settings: settings);

  final Map<StreamName, BookingState> _snapshots = {};

  bool hasSnapshot(StreamName name) => _snapshots.containsKey(name);

  @override
  Future<BookingState?> read(StreamName name) async {
    return _snapshots[name];
  }

  @override
  Future<void> write(StreamName name, BookingState state) async {
    _snapshots[name] = state;
  }
}
