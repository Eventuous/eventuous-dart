import 'package:eventuous/eventuous.dart';

import 'bar.dart';
import 'bar_value.dart';

part 'bar_state.g.dart';

@AggregateStateType(Bar)
class BarState extends _$BarState {
  BarState([BarValue? value, int? version]) : super(value, version);
}
