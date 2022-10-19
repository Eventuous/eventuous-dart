import 'dart:async';

import 'package:eventuous/eventuous.dart';
import 'package:grpc/grpc.dart';

import '../generated/bar/bar_app.pbgrpc.dart';
import 'bar.dart';
import 'bar_id.dart';
import 'bar_state.dart';
import 'bar_value.dart';
import 'bar_commands.dart';

part 'bar_app.g.dart';

@GrpcServiceType(Bar)
class BarGrpcQueryService extends _$BarGrpcQueryService {
  BarGrpcQueryService(BarApp app) : super(app);
}

@GrpcServiceType(Bar)
class BarGrpcCommandService extends _$BarGrpcCommandService {
  BarGrpcCommandService(BarApp app) : super(app);
}

@ApplicationType(Bar)
class BarApp extends _$BarApp {
  BarApp(BarStore store) : super(store);
}
