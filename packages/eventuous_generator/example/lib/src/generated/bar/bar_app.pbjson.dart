///
//  Generated code. Do not modify.
//  source: bar/bar_app.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use createBarRequestDescriptor instead')
const CreateBarRequest$json = const {
  '1': 'CreateBarRequest',
  '2': const [
    const {'1': 'barId', '3': 1, '4': 1, '5': 9, '10': 'barId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
  ],
};

/// Descriptor for `CreateBarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBarRequestDescriptor = $convert.base64Decode('ChBDcmVhdGVCYXJSZXF1ZXN0EhQKBWJhcklkGAEgASgJUgViYXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAMgASgJUgZhdXRob3I=');
@$core.Deprecated('Use createBarResponseDescriptor instead')
const CreateBarResponse$json = const {
  '1': 'CreateBarResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.CreateBarResponse.Success', '9': 0, '10': 'success'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.CreateBarResponse.Error', '9': 0, '10': 'error'},
  ],
  '3': const [CreateBarResponse_Success$json, CreateBarResponse_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use createBarResponseDescriptor instead')
const CreateBarResponse_Success$json = const {
  '1': 'Success',
};

@$core.Deprecated('Use createBarResponseDescriptor instead')
const CreateBarResponse_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `CreateBarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBarResponseDescriptor = $convert.base64Decode('ChFDcmVhdGVCYXJSZXNwb25zZRI2CgdzdWNjZXNzGAEgASgLMhouQ3JlYXRlQmFyUmVzcG9uc2UuU3VjY2Vzc0gAUgdzdWNjZXNzEjAKBWVycm9yGAIgASgLMhguQ3JlYXRlQmFyUmVzcG9uc2UuRXJyb3JIAFIFZXJyb3IaCQoHU3VjY2VzcxpLCgVFcnJvchIeCgpzdGF0dXNDb2RlGAEgASgFUgpzdGF0dXNDb2RlEiIKDHJlYXNvblBocmFzZRgCIAEoCVIMcmVhc29uUGhyYXNlQggKBnJlc3VsdA==');
@$core.Deprecated('Use updateBarRequestDescriptor instead')
const UpdateBarRequest$json = const {
  '1': 'UpdateBarRequest',
  '2': const [
    const {'1': 'barId', '3': 1, '4': 1, '5': 9, '10': 'barId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
  ],
};

/// Descriptor for `UpdateBarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBarRequestDescriptor = $convert.base64Decode('ChBVcGRhdGVCYXJSZXF1ZXN0EhQKBWJhcklkGAEgASgJUgViYXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAMgASgJUgZhdXRob3I=');
@$core.Deprecated('Use updateBarResponseDescriptor instead')
const UpdateBarResponse$json = const {
  '1': 'UpdateBarResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.UpdateBarResponse.Success', '9': 0, '10': 'success'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.UpdateBarResponse.Error', '9': 0, '10': 'error'},
  ],
  '3': const [UpdateBarResponse_Success$json, UpdateBarResponse_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use updateBarResponseDescriptor instead')
const UpdateBarResponse_Success$json = const {
  '1': 'Success',
};

@$core.Deprecated('Use updateBarResponseDescriptor instead')
const UpdateBarResponse_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `UpdateBarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBarResponseDescriptor = $convert.base64Decode('ChFVcGRhdGVCYXJSZXNwb25zZRI2CgdzdWNjZXNzGAEgASgLMhouVXBkYXRlQmFyUmVzcG9uc2UuU3VjY2Vzc0gAUgdzdWNjZXNzEjAKBWVycm9yGAIgASgLMhguVXBkYXRlQmFyUmVzcG9uc2UuRXJyb3JIAFIFZXJyb3IaCQoHU3VjY2VzcxpLCgVFcnJvchIeCgpzdGF0dXNDb2RlGAEgASgFUgpzdGF0dXNDb2RlEiIKDHJlYXNvblBocmFzZRgCIAEoCVIMcmVhc29uUGhyYXNlQggKBnJlc3VsdA==');
@$core.Deprecated('Use importBarRequestDescriptor instead')
const ImportBarRequest$json = const {
  '1': 'ImportBarRequest',
  '2': const [
    const {'1': 'barId', '3': 1, '4': 1, '5': 9, '10': 'barId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
  ],
};

/// Descriptor for `ImportBarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importBarRequestDescriptor = $convert.base64Decode('ChBJbXBvcnRCYXJSZXF1ZXN0EhQKBWJhcklkGAEgASgJUgViYXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAMgASgJUgZhdXRob3I=');
@$core.Deprecated('Use importBarResponseDescriptor instead')
const ImportBarResponse$json = const {
  '1': 'ImportBarResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.ImportBarResponse.Success', '9': 0, '10': 'success'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.ImportBarResponse.Error', '9': 0, '10': 'error'},
  ],
  '3': const [ImportBarResponse_Success$json, ImportBarResponse_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use importBarResponseDescriptor instead')
const ImportBarResponse_Success$json = const {
  '1': 'Success',
};

@$core.Deprecated('Use importBarResponseDescriptor instead')
const ImportBarResponse_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `ImportBarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importBarResponseDescriptor = $convert.base64Decode('ChFJbXBvcnRCYXJSZXNwb25zZRI2CgdzdWNjZXNzGAEgASgLMhouSW1wb3J0QmFyUmVzcG9uc2UuU3VjY2Vzc0gAUgdzdWNjZXNzEjAKBWVycm9yGAIgASgLMhguSW1wb3J0QmFyUmVzcG9uc2UuRXJyb3JIAFIFZXJyb3IaCQoHU3VjY2VzcxpLCgVFcnJvchIeCgpzdGF0dXNDb2RlGAEgASgFUgpzdGF0dXNDb2RlEiIKDHJlYXNvblBocmFzZRgCIAEoCVIMcmVhc29uUGhyYXNlQggKBnJlc3VsdA==');
@$core.Deprecated('Use barId1EventDescriptor instead')
const BarId1Event$json = const {
  '1': 'BarId1Event',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `BarId1Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barId1EventDescriptor = $convert.base64Decode('CgtCYXJJZDFFdmVudBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use barEventDescriptor instead')
const BarEvent$json = const {
  '1': 'BarEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'state', '3': 2, '4': 1, '5': 11, '6': '.BarEvent.BarState', '10': 'state'},
  ],
  '3': const [BarEvent_BarState$json],
};

@$core.Deprecated('Use barEventDescriptor instead')
const BarEvent_BarState$json = const {
  '1': 'BarState',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 2, '4': 1, '5': 11, '6': '.BarEvent.BarState.BarAuthor', '10': 'author'},
  ],
  '3': const [BarEvent_BarState_BarAuthor$json],
};

@$core.Deprecated('Use barEventDescriptor instead')
const BarEvent_BarState_BarAuthor$json = const {
  '1': 'BarAuthor',
  '2': const [
    const {'1': 'fname', '3': 1, '4': 1, '5': 9, '10': 'fname'},
    const {'1': 'lname', '3': 2, '4': 1, '5': 9, '10': 'lname'},
  ],
};

/// Descriptor for `BarEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barEventDescriptor = $convert.base64Decode('CghCYXJFdmVudBIOCgJpZBgBIAEoCVICaWQSKAoFc3RhdGUYAiABKAsyEi5CYXJFdmVudC5CYXJTdGF0ZVIFc3RhdGUajwEKCEJhclN0YXRlEhQKBXRpdGxlGAEgASgJUgV0aXRsZRI0CgZhdXRob3IYAiABKAsyHC5CYXJFdmVudC5CYXJTdGF0ZS5CYXJBdXRob3JSBmF1dGhvcho3CglCYXJBdXRob3ISFAoFZm5hbWUYASABKAlSBWZuYW1lEhQKBWxuYW1lGAIgASgJUgVsbmFtZQ==');
@$core.Deprecated('Use subscribeToBarEventsRequestDescriptor instead')
const SubscribeToBarEventsRequest$json = const {
  '1': 'SubscribeToBarEventsRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id'},
    const {'1': 'all', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Empty', '9': 0, '10': 'all'},
  ],
  '8': const [
    const {'1': 'from'},
  ],
};

/// Descriptor for `SubscribeToBarEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeToBarEventsRequestDescriptor = $convert.base64Decode('ChtTdWJzY3JpYmVUb0JhckV2ZW50c1JlcXVlc3QSEAoCaWQYASABKAlIAFICaWQSKgoDYWxsGAIgASgLMhYuZ29vZ2xlLnByb3RvYnVmLkVtcHR5SABSA2FsbEIGCgRmcm9t');
@$core.Deprecated('Use barStateRequestDescriptor instead')
const BarStateRequest$json = const {
  '1': 'BarStateRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `BarStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barStateRequestDescriptor = $convert.base64Decode('Cg9CYXJTdGF0ZVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use barStateResponseDescriptor instead')
const BarStateResponse$json = const {
  '1': 'BarStateResponse',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 11, '6': '.BarStateResponse.BarState', '9': 0, '10': 'state'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.BarStateResponse.Error', '9': 0, '10': 'error'},
  ],
  '3': const [BarStateResponse_BarState$json, BarStateResponse_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use barStateResponseDescriptor instead')
const BarStateResponse_BarState$json = const {
  '1': 'BarState',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 2, '4': 1, '5': 11, '6': '.BarStateResponse.BarState.BarAuthor', '10': 'author'},
  ],
  '3': const [BarStateResponse_BarState_BarAuthor$json],
};

@$core.Deprecated('Use barStateResponseDescriptor instead')
const BarStateResponse_BarState_BarAuthor$json = const {
  '1': 'BarAuthor',
  '2': const [
    const {'1': 'fname', '3': 1, '4': 1, '5': 9, '10': 'fname'},
    const {'1': 'lname', '3': 2, '4': 1, '5': 9, '10': 'lname'},
  ],
};

@$core.Deprecated('Use barStateResponseDescriptor instead')
const BarStateResponse_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `BarStateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barStateResponseDescriptor = $convert.base64Decode('ChBCYXJTdGF0ZVJlc3BvbnNlEjIKBXN0YXRlGAEgASgLMhouQmFyU3RhdGVSZXNwb25zZS5CYXJTdGF0ZUgAUgVzdGF0ZRIvCgVlcnJvchgCIAEoCzIXLkJhclN0YXRlUmVzcG9uc2UuRXJyb3JIAFIFZXJyb3IalwEKCEJhclN0YXRlEhQKBXRpdGxlGAEgASgJUgV0aXRsZRI8CgZhdXRob3IYAiABKAsyJC5CYXJTdGF0ZVJlc3BvbnNlLkJhclN0YXRlLkJhckF1dGhvclIGYXV0aG9yGjcKCUJhckF1dGhvchIUCgVmbmFtZRgBIAEoCVIFZm5hbWUSFAoFbG5hbWUYAiABKAlSBWxuYW1lGksKBUVycm9yEh4KCnN0YXR1c0NvZGUYASABKAVSCnN0YXR1c0NvZGUSIgoMcmVhc29uUGhyYXNlGAIgASgJUgxyZWFzb25QaHJhc2VCCAoGcmVzdWx0');
