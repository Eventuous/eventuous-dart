import 'package:eventuous/eventuous.dart';

import '../booking.dart';

class BookingStateStore
    extends AggregateStateStore<BookingStateModel, BookingState> {
  BookingStateStore({
    AggregateStateCreator<BookingStateModel, BookingState>? onNew,
  }) : super(onNew: onNew);

  final Map<StreamName, BookingState> _states = {};
  @override
  Future<BookingState> load(StreamName name) async {
    return _states[name] ?? newInstance();
  }

  @override
  Future<void> save(StreamName name, BookingState state) async {
    _states[name] = state;
  }
}
