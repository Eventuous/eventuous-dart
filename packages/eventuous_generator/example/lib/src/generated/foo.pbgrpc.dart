///
//  Generated code. Do not modify.
//  source: foo.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'foo.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
export 'foo.pb.dart';

class FooGrpcCommandServiceClient extends $grpc.Client {
  static final _$executeCreateFoo =
      $grpc.ClientMethod<$0.CreateFooRequest, $0.CreateFooResponse>(
          '/FooGrpcCommandService/ExecuteCreateFoo',
          ($0.CreateFooRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateFooResponse.fromBuffer(value));
  static final _$executeUpdateFoo =
      $grpc.ClientMethod<$0.UpdateFooRequest, $0.UpdateFooResponse>(
          '/FooGrpcCommandService/ExecuteUpdateFoo',
          ($0.UpdateFooRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateFooResponse.fromBuffer(value));
  static final _$executeImportFoo =
      $grpc.ClientMethod<$0.ImportFooRequest, $0.ImportFooResponse>(
          '/FooGrpcCommandService/ExecuteImportFoo',
          ($0.ImportFooRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ImportFooResponse.fromBuffer(value));

  FooGrpcCommandServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateFooResponse> executeCreateFoo(
      $0.CreateFooRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeCreateFoo, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateFooResponse> executeUpdateFoo(
      $0.UpdateFooRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeUpdateFoo, request, options: options);
  }

  $grpc.ResponseFuture<$0.ImportFooResponse> executeImportFoo(
      $0.ImportFooRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeImportFoo, request, options: options);
  }
}

abstract class FooGrpcCommandServiceBase extends $grpc.Service {
  $core.String get $name => 'FooGrpcCommandService';

  FooGrpcCommandServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateFooRequest, $0.CreateFooResponse>(
        'ExecuteCreateFoo',
        executeCreateFoo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateFooRequest.fromBuffer(value),
        ($0.CreateFooResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFooRequest, $0.UpdateFooResponse>(
        'ExecuteUpdateFoo',
        executeUpdateFoo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateFooRequest.fromBuffer(value),
        ($0.UpdateFooResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ImportFooRequest, $0.ImportFooResponse>(
        'ExecuteImportFoo',
        executeImportFoo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ImportFooRequest.fromBuffer(value),
        ($0.ImportFooResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateFooResponse> executeCreateFoo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateFooRequest> request) async {
    return executeCreateFoo(call, await request);
  }

  $async.Future<$0.UpdateFooResponse> executeUpdateFoo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateFooRequest> request) async {
    return executeUpdateFoo(call, await request);
  }

  $async.Future<$0.ImportFooResponse> executeImportFoo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ImportFooRequest> request) async {
    return executeImportFoo(call, await request);
  }

  $async.Future<$0.CreateFooResponse> executeCreateFoo(
      $grpc.ServiceCall call, $0.CreateFooRequest request);
  $async.Future<$0.UpdateFooResponse> executeUpdateFoo(
      $grpc.ServiceCall call, $0.UpdateFooRequest request);
  $async.Future<$0.ImportFooResponse> executeImportFoo(
      $grpc.ServiceCall call, $0.ImportFooRequest request);
}

class FooGrpcQueryServiceClient extends $grpc.Client {
  static final _$getFooIds = $grpc.ClientMethod<$1.Empty, $0.FooIdEvent>(
      '/FooGrpcQueryService/GetFooIds',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FooIdEvent.fromBuffer(value));
  static final _$getFooState1 =
      $grpc.ClientMethod<$0.FooState1Request, $0.FooState1Response>(
          '/FooGrpcQueryService/GetFooState1',
          ($0.FooState1Request value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.FooState1Response.fromBuffer(value));
  static final _$subscribeToFooEvents =
      $grpc.ClientMethod<$0.SubscribeToFooEventsRequest, $0.FooEvent>(
          '/FooGrpcQueryService/SubscribeToFooEvents',
          ($0.SubscribeToFooEventsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.FooEvent.fromBuffer(value));

  FooGrpcQueryServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.FooIdEvent> getFooIds($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getFooIds, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.FooState1Response> getFooState1(
      $0.FooState1Request request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFooState1, request, options: options);
  }

  $grpc.ResponseStream<$0.FooEvent> subscribeToFooEvents(
      $0.SubscribeToFooEventsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribeToFooEvents, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class FooGrpcQueryServiceBase extends $grpc.Service {
  $core.String get $name => 'FooGrpcQueryService';

  FooGrpcQueryServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.FooIdEvent>(
        'GetFooIds',
        getFooIds_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.FooIdEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FooState1Request, $0.FooState1Response>(
        'GetFooState1',
        getFooState1_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FooState1Request.fromBuffer(value),
        ($0.FooState1Response value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubscribeToFooEventsRequest, $0.FooEvent>(
        'SubscribeToFooEvents',
        subscribeToFooEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.SubscribeToFooEventsRequest.fromBuffer(value),
        ($0.FooEvent value) => value.writeToBuffer()));
  }

  $async.Stream<$0.FooIdEvent> getFooIds_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* getFooIds(call, await request);
  }

  $async.Future<$0.FooState1Response> getFooState1_Pre($grpc.ServiceCall call,
      $async.Future<$0.FooState1Request> request) async {
    return getFooState1(call, await request);
  }

  $async.Stream<$0.FooEvent> subscribeToFooEvents_Pre($grpc.ServiceCall call,
      $async.Future<$0.SubscribeToFooEventsRequest> request) async* {
    yield* subscribeToFooEvents(call, await request);
  }

  $async.Stream<$0.FooIdEvent> getFooIds(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$0.FooState1Response> getFooState1(
      $grpc.ServiceCall call, $0.FooState1Request request);
  $async.Stream<$0.FooEvent> subscribeToFooEvents(
      $grpc.ServiceCall call, $0.SubscribeToFooEventsRequest request);
}
