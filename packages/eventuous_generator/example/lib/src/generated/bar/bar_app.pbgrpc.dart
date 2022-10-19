///
//  Generated code. Do not modify.
//  source: bar/bar_app.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'bar_app.pb.dart' as $2;
export 'bar_app.pb.dart';

class BarGrpcCommandServiceClient extends $grpc.Client {
  static final _$executeCreateBar =
      $grpc.ClientMethod<$2.CreateBarRequest, $2.CreateBarResponse>(
          '/BarGrpcCommandService/ExecuteCreateBar',
          ($2.CreateBarRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.CreateBarResponse.fromBuffer(value));
  static final _$executeUpdateBar =
      $grpc.ClientMethod<$2.UpdateBarRequest, $2.UpdateBarResponse>(
          '/BarGrpcCommandService/ExecuteUpdateBar',
          ($2.UpdateBarRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.UpdateBarResponse.fromBuffer(value));
  static final _$executeImportBar =
      $grpc.ClientMethod<$2.ImportBarRequest, $2.ImportBarResponse>(
          '/BarGrpcCommandService/ExecuteImportBar',
          ($2.ImportBarRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ImportBarResponse.fromBuffer(value));

  BarGrpcCommandServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.CreateBarResponse> executeCreateBar(
      $2.CreateBarRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeCreateBar, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateBarResponse> executeUpdateBar(
      $2.UpdateBarRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeUpdateBar, request, options: options);
  }

  $grpc.ResponseFuture<$2.ImportBarResponse> executeImportBar(
      $2.ImportBarRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeImportBar, request, options: options);
  }
}

abstract class BarGrpcCommandServiceBase extends $grpc.Service {
  $core.String get $name => 'BarGrpcCommandService';

  BarGrpcCommandServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateBarRequest, $2.CreateBarResponse>(
        'ExecuteCreateBar',
        executeCreateBar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CreateBarRequest.fromBuffer(value),
        ($2.CreateBarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateBarRequest, $2.UpdateBarResponse>(
        'ExecuteUpdateBar',
        executeUpdateBar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UpdateBarRequest.fromBuffer(value),
        ($2.UpdateBarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ImportBarRequest, $2.ImportBarResponse>(
        'ExecuteImportBar',
        executeImportBar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ImportBarRequest.fromBuffer(value),
        ($2.ImportBarResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.CreateBarResponse> executeCreateBar_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.CreateBarRequest> request) async {
    return executeCreateBar(call, await request);
  }

  $async.Future<$2.UpdateBarResponse> executeUpdateBar_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.UpdateBarRequest> request) async {
    return executeUpdateBar(call, await request);
  }

  $async.Future<$2.ImportBarResponse> executeImportBar_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ImportBarRequest> request) async {
    return executeImportBar(call, await request);
  }

  $async.Future<$2.CreateBarResponse> executeCreateBar(
      $grpc.ServiceCall call, $2.CreateBarRequest request);
  $async.Future<$2.UpdateBarResponse> executeUpdateBar(
      $grpc.ServiceCall call, $2.UpdateBarRequest request);
  $async.Future<$2.ImportBarResponse> executeImportBar(
      $grpc.ServiceCall call, $2.ImportBarRequest request);
}

class BarGrpcQueryServiceClient extends $grpc.Client {
  static final _$subscribeToBarEvents =
      $grpc.ClientMethod<$2.SubscribeToBarEventsRequest, $2.BarEvent>(
          '/BarGrpcQueryService/SubscribeToBarEvents',
          ($2.SubscribeToBarEventsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BarEvent.fromBuffer(value));

  BarGrpcQueryServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$2.BarEvent> subscribeToBarEvents(
      $2.SubscribeToBarEventsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribeToBarEvents, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class BarGrpcQueryServiceBase extends $grpc.Service {
  $core.String get $name => 'BarGrpcQueryService';

  BarGrpcQueryServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.SubscribeToBarEventsRequest, $2.BarEvent>(
        'SubscribeToBarEvents',
        subscribeToBarEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $2.SubscribeToBarEventsRequest.fromBuffer(value),
        ($2.BarEvent value) => value.writeToBuffer()));
  }

  $async.Stream<$2.BarEvent> subscribeToBarEvents_Pre($grpc.ServiceCall call,
      $async.Future<$2.SubscribeToBarEventsRequest> request) async* {
    yield* subscribeToBarEvents(call, await request);
  }

  $async.Stream<$2.BarEvent> subscribeToBarEvents(
      $grpc.ServiceCall call, $2.SubscribeToBarEventsRequest request);
}
