import 'package:eventuous/eventuous.dart';

import 'bar_id.dart';
import 'bar_state.dart';
import 'bar_value.dart';

part 'bar.g.dart';

@AggregateType(
  id: BarId1,
  event: JsonObject,
  state: BarState,
  value: BarValue,
)
class Bar extends _$Bar {
  Bar(BarId1 id, [BarState? state]) : super(id, state);
}
