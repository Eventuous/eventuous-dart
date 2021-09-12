import 'package:eventuous/eventuous.dart';

import '../booking.dart';

class BookingStateStorage
    extends AggregateStateStorage<BookingStateModel, BookingState> {
  BookingStateStorage({
    AggregateStateCreator<BookingStateModel, BookingState>? onNew,
    AggregateStateStorageSettings settings =
        AggregateStateStorageSettings.Default,
  }) : super(onNew: onNew, settings: settings);

  final Map<StreamName, AggregateStateSnapshotModel<BookingStateModel>>
      _snapshots = {};

  bool hasSnapshot(StreamName name) => _snapshots.containsKey(name);

  @override
  Future<AggregateStateSnapshotModel<BookingStateModel>?> read(
      StreamName name) async {
    return _snapshots[name];
  }

  @override
  Future<void> write(
    StreamName name,
    AggregateStateSnapshotModel<BookingStateModel> snapshot,
  ) async {
    _snapshots[name] = snapshot;
  }
}
