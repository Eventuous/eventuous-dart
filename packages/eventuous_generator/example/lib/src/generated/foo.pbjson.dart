///
//  Generated code. Do not modify.
//  source: foo.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use createFooRequestDescriptor instead')
const CreateFooRequest$json = const {
  '1': 'CreateFooRequest',
  '2': const [
    const {'1': 'fooId', '3': 1, '4': 1, '5': 9, '10': 'fooId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
  ],
};

/// Descriptor for `CreateFooRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFooRequestDescriptor = $convert.base64Decode('ChBDcmVhdGVGb29SZXF1ZXN0EhQKBWZvb0lkGAEgASgJUgVmb29JZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAMgASgJUgZhdXRob3I=');
@$core.Deprecated('Use createFooResponseDescriptor instead')
const CreateFooResponse$json = const {
  '1': 'CreateFooResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.CreateFooResponse.Success', '9': 0, '10': 'success'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.CreateFooResponse.Error', '9': 0, '10': 'error'},
  ],
  '3': const [CreateFooResponse_Success$json, CreateFooResponse_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use createFooResponseDescriptor instead')
const CreateFooResponse_Success$json = const {
  '1': 'Success',
};

@$core.Deprecated('Use createFooResponseDescriptor instead')
const CreateFooResponse_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `CreateFooResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFooResponseDescriptor = $convert.base64Decode('ChFDcmVhdGVGb29SZXNwb25zZRI2CgdzdWNjZXNzGAEgASgLMhouQ3JlYXRlRm9vUmVzcG9uc2UuU3VjY2Vzc0gAUgdzdWNjZXNzEjAKBWVycm9yGAIgASgLMhguQ3JlYXRlRm9vUmVzcG9uc2UuRXJyb3JIAFIFZXJyb3IaCQoHU3VjY2VzcxpLCgVFcnJvchIeCgpzdGF0dXNDb2RlGAEgASgFUgpzdGF0dXNDb2RlEiIKDHJlYXNvblBocmFzZRgCIAEoCVIMcmVhc29uUGhyYXNlQggKBnJlc3VsdA==');
@$core.Deprecated('Use updateFooRequestDescriptor instead')
const UpdateFooRequest$json = const {
  '1': 'UpdateFooRequest',
  '2': const [
    const {'1': 'fooId', '3': 1, '4': 1, '5': 9, '10': 'fooId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
  ],
};

/// Descriptor for `UpdateFooRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFooRequestDescriptor = $convert.base64Decode('ChBVcGRhdGVGb29SZXF1ZXN0EhQKBWZvb0lkGAEgASgJUgVmb29JZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAMgASgJUgZhdXRob3I=');
@$core.Deprecated('Use updateFooResponseDescriptor instead')
const UpdateFooResponse$json = const {
  '1': 'UpdateFooResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.UpdateFooResponse.Success', '9': 0, '10': 'success'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.UpdateFooResponse.Error', '9': 0, '10': 'error'},
  ],
  '3': const [UpdateFooResponse_Success$json, UpdateFooResponse_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use updateFooResponseDescriptor instead')
const UpdateFooResponse_Success$json = const {
  '1': 'Success',
};

@$core.Deprecated('Use updateFooResponseDescriptor instead')
const UpdateFooResponse_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `UpdateFooResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFooResponseDescriptor = $convert.base64Decode('ChFVcGRhdGVGb29SZXNwb25zZRI2CgdzdWNjZXNzGAEgASgLMhouVXBkYXRlRm9vUmVzcG9uc2UuU3VjY2Vzc0gAUgdzdWNjZXNzEjAKBWVycm9yGAIgASgLMhguVXBkYXRlRm9vUmVzcG9uc2UuRXJyb3JIAFIFZXJyb3IaCQoHU3VjY2VzcxpLCgVFcnJvchIeCgpzdGF0dXNDb2RlGAEgASgFUgpzdGF0dXNDb2RlEiIKDHJlYXNvblBocmFzZRgCIAEoCVIMcmVhc29uUGhyYXNlQggKBnJlc3VsdA==');
@$core.Deprecated('Use importFooRequestDescriptor instead')
const ImportFooRequest$json = const {
  '1': 'ImportFooRequest',
  '2': const [
    const {'1': 'fooId', '3': 1, '4': 1, '5': 9, '10': 'fooId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
  ],
};

/// Descriptor for `ImportFooRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importFooRequestDescriptor = $convert.base64Decode('ChBJbXBvcnRGb29SZXF1ZXN0EhQKBWZvb0lkGAEgASgJUgVmb29JZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAMgASgJUgZhdXRob3I=');
@$core.Deprecated('Use importFooResponseDescriptor instead')
const ImportFooResponse$json = const {
  '1': 'ImportFooResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.ImportFooResponse.Success', '9': 0, '10': 'success'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.ImportFooResponse.Error', '9': 0, '10': 'error'},
  ],
  '3': const [ImportFooResponse_Success$json, ImportFooResponse_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use importFooResponseDescriptor instead')
const ImportFooResponse_Success$json = const {
  '1': 'Success',
};

@$core.Deprecated('Use importFooResponseDescriptor instead')
const ImportFooResponse_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `ImportFooResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importFooResponseDescriptor = $convert.base64Decode('ChFJbXBvcnRGb29SZXNwb25zZRI2CgdzdWNjZXNzGAEgASgLMhouSW1wb3J0Rm9vUmVzcG9uc2UuU3VjY2Vzc0gAUgdzdWNjZXNzEjAKBWVycm9yGAIgASgLMhguSW1wb3J0Rm9vUmVzcG9uc2UuRXJyb3JIAFIFZXJyb3IaCQoHU3VjY2VzcxpLCgVFcnJvchIeCgpzdGF0dXNDb2RlGAEgASgFUgpzdGF0dXNDb2RlEiIKDHJlYXNvblBocmFzZRgCIAEoCVIMcmVhc29uUGhyYXNlQggKBnJlc3VsdA==');
@$core.Deprecated('Use fooIdEventDescriptor instead')
const FooIdEvent$json = const {
  '1': 'FooIdEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `FooIdEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fooIdEventDescriptor = $convert.base64Decode('CgpGb29JZEV2ZW50Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use fooEventDescriptor instead')
const FooEvent$json = const {
  '1': 'FooEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'state', '3': 2, '4': 1, '5': 11, '6': '.FooEvent.FooState1', '10': 'state'},
  ],
  '3': const [FooEvent_FooState1$json],
};

@$core.Deprecated('Use fooEventDescriptor instead')
const FooEvent_FooState1$json = const {
  '1': 'FooState1',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 2, '4': 1, '5': 9, '10': 'author'},
  ],
};

/// Descriptor for `FooEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fooEventDescriptor = $convert.base64Decode('CghGb29FdmVudBIOCgJpZBgBIAEoCVICaWQSKQoFc3RhdGUYAiABKAsyEy5Gb29FdmVudC5Gb29TdGF0ZTFSBXN0YXRlGjkKCUZvb1N0YXRlMRIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAIgASgJUgZhdXRob3I=');
@$core.Deprecated('Use subscribeToFooEventsRequestDescriptor instead')
const SubscribeToFooEventsRequest$json = const {
  '1': 'SubscribeToFooEventsRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id'},
    const {'1': 'all', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Empty', '9': 0, '10': 'all'},
  ],
  '8': const [
    const {'1': 'from'},
  ],
};

/// Descriptor for `SubscribeToFooEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeToFooEventsRequestDescriptor = $convert.base64Decode('ChtTdWJzY3JpYmVUb0Zvb0V2ZW50c1JlcXVlc3QSEAoCaWQYASABKAlIAFICaWQSKgoDYWxsGAIgASgLMhYuZ29vZ2xlLnByb3RvYnVmLkVtcHR5SABSA2FsbEIGCgRmcm9t');
@$core.Deprecated('Use fooState1RequestDescriptor instead')
const FooState1Request$json = const {
  '1': 'FooState1Request',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `FooState1Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fooState1RequestDescriptor = $convert.base64Decode('ChBGb29TdGF0ZTFSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use fooState1ResponseDescriptor instead')
const FooState1Response$json = const {
  '1': 'FooState1Response',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 11, '6': '.FooState1Response.FooState1', '9': 0, '10': 'state'},
    const {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.FooState1Response.Error', '9': 0, '10': 'error'},
  ],
  '3': const [FooState1Response_FooState1$json, FooState1Response_Error$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use fooState1ResponseDescriptor instead')
const FooState1Response_FooState1$json = const {
  '1': 'FooState1',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 2, '4': 1, '5': 9, '10': 'author'},
  ],
};

@$core.Deprecated('Use fooState1ResponseDescriptor instead')
const FooState1Response_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'statusCode', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    const {'1': 'reasonPhrase', '3': 2, '4': 1, '5': 9, '10': 'reasonPhrase'},
  ],
};

/// Descriptor for `FooState1Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fooState1ResponseDescriptor = $convert.base64Decode('ChFGb29TdGF0ZTFSZXNwb25zZRI0CgVzdGF0ZRgBIAEoCzIcLkZvb1N0YXRlMVJlc3BvbnNlLkZvb1N0YXRlMUgAUgVzdGF0ZRIwCgVlcnJvchgCIAEoCzIYLkZvb1N0YXRlMVJlc3BvbnNlLkVycm9ySABSBWVycm9yGjkKCUZvb1N0YXRlMRIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSFgoGYXV0aG9yGAIgASgJUgZhdXRob3IaSwoFRXJyb3ISHgoKc3RhdHVzQ29kZRgBIAEoBVIKc3RhdHVzQ29kZRIiCgxyZWFzb25QaHJhc2UYAiABKAlSDHJlYXNvblBocmFzZUIICgZyZXN1bHQ=');
