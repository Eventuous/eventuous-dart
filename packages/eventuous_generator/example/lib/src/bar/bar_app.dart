import 'dart:async';

import 'package:eventuous/eventuous.dart';

import 'bar.dart';
import 'bar_id.dart';
import 'bar_state.dart';
import 'bar_value.dart';
import 'bar_commands.dart';

part 'bar_app.g.dart';

@ApplicationType(Bar)
class BarApp extends _$BarApp {
  BarApp(BarStore store) : super(store);
}
