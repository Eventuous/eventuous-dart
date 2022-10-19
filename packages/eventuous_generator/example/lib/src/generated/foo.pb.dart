///
//  Generated code. Do not modify.
//  source: foo.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/empty.pb.dart' as $1;

class CreateFooRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFooRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fooId', protoName: 'fooId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  CreateFooRequest._() : super();
  factory CreateFooRequest({
    $core.String? fooId,
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (fooId != null) {
      _result.fooId = fooId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory CreateFooRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFooRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFooRequest clone() => CreateFooRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFooRequest copyWith(void Function(CreateFooRequest) updates) => super.copyWith((message) => updates(message as CreateFooRequest)) as CreateFooRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFooRequest create() => CreateFooRequest._();
  CreateFooRequest createEmptyInstance() => create();
  static $pb.PbList<CreateFooRequest> createRepeated() => $pb.PbList<CreateFooRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateFooRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFooRequest>(create);
  static CreateFooRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fooId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fooId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFooId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFooId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => clearField(3);
}

class CreateFooResponse_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFooResponse.Success', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CreateFooResponse_Success._() : super();
  factory CreateFooResponse_Success() => create();
  factory CreateFooResponse_Success.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFooResponse_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFooResponse_Success clone() => CreateFooResponse_Success()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFooResponse_Success copyWith(void Function(CreateFooResponse_Success) updates) => super.copyWith((message) => updates(message as CreateFooResponse_Success)) as CreateFooResponse_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFooResponse_Success create() => CreateFooResponse_Success._();
  CreateFooResponse_Success createEmptyInstance() => create();
  static $pb.PbList<CreateFooResponse_Success> createRepeated() => $pb.PbList<CreateFooResponse_Success>();
  @$core.pragma('dart2js:noInline')
  static CreateFooResponse_Success getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFooResponse_Success>(create);
  static CreateFooResponse_Success? _defaultInstance;
}

class CreateFooResponse_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFooResponse.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  CreateFooResponse_Error._() : super();
  factory CreateFooResponse_Error({
    $core.int? statusCode,
    $core.String? reasonPhrase,
  }) {
    final _result = create();
    if (statusCode != null) {
      _result.statusCode = statusCode;
    }
    if (reasonPhrase != null) {
      _result.reasonPhrase = reasonPhrase;
    }
    return _result;
  }
  factory CreateFooResponse_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFooResponse_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFooResponse_Error clone() => CreateFooResponse_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFooResponse_Error copyWith(void Function(CreateFooResponse_Error) updates) => super.copyWith((message) => updates(message as CreateFooResponse_Error)) as CreateFooResponse_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFooResponse_Error create() => CreateFooResponse_Error._();
  CreateFooResponse_Error createEmptyInstance() => create();
  static $pb.PbList<CreateFooResponse_Error> createRepeated() => $pb.PbList<CreateFooResponse_Error>();
  @$core.pragma('dart2js:noInline')
  static CreateFooResponse_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFooResponse_Error>(create);
  static CreateFooResponse_Error? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get statusCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set statusCode($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatusCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatusCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reasonPhrase => $_getSZ(1);
  @$pb.TagNumber(2)
  set reasonPhrase($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReasonPhrase() => $_has(1);
  @$pb.TagNumber(2)
  void clearReasonPhrase() => clearField(2);
}

enum CreateFooResponse_Result {
  success, 
  error, 
  notSet
}

class CreateFooResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, CreateFooResponse_Result> _CreateFooResponse_ResultByTag = {
    1 : CreateFooResponse_Result.success,
    2 : CreateFooResponse_Result.error,
    0 : CreateFooResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFooResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<CreateFooResponse_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success', subBuilder: CreateFooResponse_Success.create)
    ..aOM<CreateFooResponse_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: CreateFooResponse_Error.create)
    ..hasRequiredFields = false
  ;

  CreateFooResponse._() : super();
  factory CreateFooResponse({
    CreateFooResponse_Success? success,
    CreateFooResponse_Error? error,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory CreateFooResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFooResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFooResponse clone() => CreateFooResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFooResponse copyWith(void Function(CreateFooResponse) updates) => super.copyWith((message) => updates(message as CreateFooResponse)) as CreateFooResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateFooResponse create() => CreateFooResponse._();
  CreateFooResponse createEmptyInstance() => create();
  static $pb.PbList<CreateFooResponse> createRepeated() => $pb.PbList<CreateFooResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateFooResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFooResponse>(create);
  static CreateFooResponse? _defaultInstance;

  CreateFooResponse_Result whichResult() => _CreateFooResponse_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  CreateFooResponse_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(CreateFooResponse_Success v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  CreateFooResponse_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateFooResponse_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(CreateFooResponse_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  CreateFooResponse_Error ensureError() => $_ensure(1);
}

class UpdateFooRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFooRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fooId', protoName: 'fooId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  UpdateFooRequest._() : super();
  factory UpdateFooRequest({
    $core.String? fooId,
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (fooId != null) {
      _result.fooId = fooId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory UpdateFooRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFooRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFooRequest clone() => UpdateFooRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFooRequest copyWith(void Function(UpdateFooRequest) updates) => super.copyWith((message) => updates(message as UpdateFooRequest)) as UpdateFooRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFooRequest create() => UpdateFooRequest._();
  UpdateFooRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFooRequest> createRepeated() => $pb.PbList<UpdateFooRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFooRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFooRequest>(create);
  static UpdateFooRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fooId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fooId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFooId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFooId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => clearField(3);
}

class UpdateFooResponse_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFooResponse.Success', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  UpdateFooResponse_Success._() : super();
  factory UpdateFooResponse_Success() => create();
  factory UpdateFooResponse_Success.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFooResponse_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFooResponse_Success clone() => UpdateFooResponse_Success()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFooResponse_Success copyWith(void Function(UpdateFooResponse_Success) updates) => super.copyWith((message) => updates(message as UpdateFooResponse_Success)) as UpdateFooResponse_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFooResponse_Success create() => UpdateFooResponse_Success._();
  UpdateFooResponse_Success createEmptyInstance() => create();
  static $pb.PbList<UpdateFooResponse_Success> createRepeated() => $pb.PbList<UpdateFooResponse_Success>();
  @$core.pragma('dart2js:noInline')
  static UpdateFooResponse_Success getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFooResponse_Success>(create);
  static UpdateFooResponse_Success? _defaultInstance;
}

class UpdateFooResponse_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFooResponse.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  UpdateFooResponse_Error._() : super();
  factory UpdateFooResponse_Error({
    $core.int? statusCode,
    $core.String? reasonPhrase,
  }) {
    final _result = create();
    if (statusCode != null) {
      _result.statusCode = statusCode;
    }
    if (reasonPhrase != null) {
      _result.reasonPhrase = reasonPhrase;
    }
    return _result;
  }
  factory UpdateFooResponse_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFooResponse_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFooResponse_Error clone() => UpdateFooResponse_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFooResponse_Error copyWith(void Function(UpdateFooResponse_Error) updates) => super.copyWith((message) => updates(message as UpdateFooResponse_Error)) as UpdateFooResponse_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFooResponse_Error create() => UpdateFooResponse_Error._();
  UpdateFooResponse_Error createEmptyInstance() => create();
  static $pb.PbList<UpdateFooResponse_Error> createRepeated() => $pb.PbList<UpdateFooResponse_Error>();
  @$core.pragma('dart2js:noInline')
  static UpdateFooResponse_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFooResponse_Error>(create);
  static UpdateFooResponse_Error? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get statusCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set statusCode($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatusCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatusCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reasonPhrase => $_getSZ(1);
  @$pb.TagNumber(2)
  set reasonPhrase($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReasonPhrase() => $_has(1);
  @$pb.TagNumber(2)
  void clearReasonPhrase() => clearField(2);
}

enum UpdateFooResponse_Result {
  success, 
  error, 
  notSet
}

class UpdateFooResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, UpdateFooResponse_Result> _UpdateFooResponse_ResultByTag = {
    1 : UpdateFooResponse_Result.success,
    2 : UpdateFooResponse_Result.error,
    0 : UpdateFooResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFooResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<UpdateFooResponse_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success', subBuilder: UpdateFooResponse_Success.create)
    ..aOM<UpdateFooResponse_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: UpdateFooResponse_Error.create)
    ..hasRequiredFields = false
  ;

  UpdateFooResponse._() : super();
  factory UpdateFooResponse({
    UpdateFooResponse_Success? success,
    UpdateFooResponse_Error? error,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory UpdateFooResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFooResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFooResponse clone() => UpdateFooResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFooResponse copyWith(void Function(UpdateFooResponse) updates) => super.copyWith((message) => updates(message as UpdateFooResponse)) as UpdateFooResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFooResponse create() => UpdateFooResponse._();
  UpdateFooResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFooResponse> createRepeated() => $pb.PbList<UpdateFooResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFooResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFooResponse>(create);
  static UpdateFooResponse? _defaultInstance;

  UpdateFooResponse_Result whichResult() => _UpdateFooResponse_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  UpdateFooResponse_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(UpdateFooResponse_Success v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  UpdateFooResponse_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  UpdateFooResponse_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(UpdateFooResponse_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  UpdateFooResponse_Error ensureError() => $_ensure(1);
}

class ImportFooRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportFooRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fooId', protoName: 'fooId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  ImportFooRequest._() : super();
  factory ImportFooRequest({
    $core.String? fooId,
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (fooId != null) {
      _result.fooId = fooId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory ImportFooRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportFooRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportFooRequest clone() => ImportFooRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportFooRequest copyWith(void Function(ImportFooRequest) updates) => super.copyWith((message) => updates(message as ImportFooRequest)) as ImportFooRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportFooRequest create() => ImportFooRequest._();
  ImportFooRequest createEmptyInstance() => create();
  static $pb.PbList<ImportFooRequest> createRepeated() => $pb.PbList<ImportFooRequest>();
  @$core.pragma('dart2js:noInline')
  static ImportFooRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportFooRequest>(create);
  static ImportFooRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fooId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fooId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFooId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFooId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => clearField(3);
}

class ImportFooResponse_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportFooResponse.Success', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ImportFooResponse_Success._() : super();
  factory ImportFooResponse_Success() => create();
  factory ImportFooResponse_Success.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportFooResponse_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportFooResponse_Success clone() => ImportFooResponse_Success()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportFooResponse_Success copyWith(void Function(ImportFooResponse_Success) updates) => super.copyWith((message) => updates(message as ImportFooResponse_Success)) as ImportFooResponse_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportFooResponse_Success create() => ImportFooResponse_Success._();
  ImportFooResponse_Success createEmptyInstance() => create();
  static $pb.PbList<ImportFooResponse_Success> createRepeated() => $pb.PbList<ImportFooResponse_Success>();
  @$core.pragma('dart2js:noInline')
  static ImportFooResponse_Success getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportFooResponse_Success>(create);
  static ImportFooResponse_Success? _defaultInstance;
}

class ImportFooResponse_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportFooResponse.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  ImportFooResponse_Error._() : super();
  factory ImportFooResponse_Error({
    $core.int? statusCode,
    $core.String? reasonPhrase,
  }) {
    final _result = create();
    if (statusCode != null) {
      _result.statusCode = statusCode;
    }
    if (reasonPhrase != null) {
      _result.reasonPhrase = reasonPhrase;
    }
    return _result;
  }
  factory ImportFooResponse_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportFooResponse_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportFooResponse_Error clone() => ImportFooResponse_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportFooResponse_Error copyWith(void Function(ImportFooResponse_Error) updates) => super.copyWith((message) => updates(message as ImportFooResponse_Error)) as ImportFooResponse_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportFooResponse_Error create() => ImportFooResponse_Error._();
  ImportFooResponse_Error createEmptyInstance() => create();
  static $pb.PbList<ImportFooResponse_Error> createRepeated() => $pb.PbList<ImportFooResponse_Error>();
  @$core.pragma('dart2js:noInline')
  static ImportFooResponse_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportFooResponse_Error>(create);
  static ImportFooResponse_Error? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get statusCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set statusCode($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatusCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatusCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reasonPhrase => $_getSZ(1);
  @$pb.TagNumber(2)
  set reasonPhrase($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReasonPhrase() => $_has(1);
  @$pb.TagNumber(2)
  void clearReasonPhrase() => clearField(2);
}

enum ImportFooResponse_Result {
  success, 
  error, 
  notSet
}

class ImportFooResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ImportFooResponse_Result> _ImportFooResponse_ResultByTag = {
    1 : ImportFooResponse_Result.success,
    2 : ImportFooResponse_Result.error,
    0 : ImportFooResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportFooResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<ImportFooResponse_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success', subBuilder: ImportFooResponse_Success.create)
    ..aOM<ImportFooResponse_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: ImportFooResponse_Error.create)
    ..hasRequiredFields = false
  ;

  ImportFooResponse._() : super();
  factory ImportFooResponse({
    ImportFooResponse_Success? success,
    ImportFooResponse_Error? error,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory ImportFooResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportFooResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportFooResponse clone() => ImportFooResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportFooResponse copyWith(void Function(ImportFooResponse) updates) => super.copyWith((message) => updates(message as ImportFooResponse)) as ImportFooResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportFooResponse create() => ImportFooResponse._();
  ImportFooResponse createEmptyInstance() => create();
  static $pb.PbList<ImportFooResponse> createRepeated() => $pb.PbList<ImportFooResponse>();
  @$core.pragma('dart2js:noInline')
  static ImportFooResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportFooResponse>(create);
  static ImportFooResponse? _defaultInstance;

  ImportFooResponse_Result whichResult() => _ImportFooResponse_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  ImportFooResponse_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(ImportFooResponse_Success v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  ImportFooResponse_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  ImportFooResponse_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(ImportFooResponse_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  ImportFooResponse_Error ensureError() => $_ensure(1);
}

class FooIdEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FooIdEvent', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  FooIdEvent._() : super();
  factory FooIdEvent({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory FooIdEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FooIdEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FooIdEvent clone() => FooIdEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FooIdEvent copyWith(void Function(FooIdEvent) updates) => super.copyWith((message) => updates(message as FooIdEvent)) as FooIdEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FooIdEvent create() => FooIdEvent._();
  FooIdEvent createEmptyInstance() => create();
  static $pb.PbList<FooIdEvent> createRepeated() => $pb.PbList<FooIdEvent>();
  @$core.pragma('dart2js:noInline')
  static FooIdEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FooIdEvent>(create);
  static FooIdEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class FooEvent_FooState1 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FooEvent.FooState1', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  FooEvent_FooState1._() : super();
  factory FooEvent_FooState1({
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory FooEvent_FooState1.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FooEvent_FooState1.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FooEvent_FooState1 clone() => FooEvent_FooState1()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FooEvent_FooState1 copyWith(void Function(FooEvent_FooState1) updates) => super.copyWith((message) => updates(message as FooEvent_FooState1)) as FooEvent_FooState1; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FooEvent_FooState1 create() => FooEvent_FooState1._();
  FooEvent_FooState1 createEmptyInstance() => create();
  static $pb.PbList<FooEvent_FooState1> createRepeated() => $pb.PbList<FooEvent_FooState1>();
  @$core.pragma('dart2js:noInline')
  static FooEvent_FooState1 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FooEvent_FooState1>(create);
  static FooEvent_FooState1? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get author => $_getSZ(1);
  @$pb.TagNumber(2)
  set author($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => clearField(2);
}

class FooEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FooEvent', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<FooEvent_FooState1>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', subBuilder: FooEvent_FooState1.create)
    ..hasRequiredFields = false
  ;

  FooEvent._() : super();
  factory FooEvent({
    $core.String? id,
    FooEvent_FooState1? state,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory FooEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FooEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FooEvent clone() => FooEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FooEvent copyWith(void Function(FooEvent) updates) => super.copyWith((message) => updates(message as FooEvent)) as FooEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FooEvent create() => FooEvent._();
  FooEvent createEmptyInstance() => create();
  static $pb.PbList<FooEvent> createRepeated() => $pb.PbList<FooEvent>();
  @$core.pragma('dart2js:noInline')
  static FooEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FooEvent>(create);
  static FooEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  FooEvent_FooState1 get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(FooEvent_FooState1 v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
  @$pb.TagNumber(2)
  FooEvent_FooState1 ensureState() => $_ensure(1);
}

enum SubscribeToFooEventsRequest_From {
  id, 
  all, 
  notSet
}

class SubscribeToFooEventsRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SubscribeToFooEventsRequest_From> _SubscribeToFooEventsRequest_FromByTag = {
    1 : SubscribeToFooEventsRequest_From.id,
    2 : SubscribeToFooEventsRequest_From.all,
    0 : SubscribeToFooEventsRequest_From.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeToFooEventsRequest', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$1.Empty>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'all', subBuilder: $1.Empty.create)
    ..hasRequiredFields = false
  ;

  SubscribeToFooEventsRequest._() : super();
  factory SubscribeToFooEventsRequest({
    $core.String? id,
    $1.Empty? all,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (all != null) {
      _result.all = all;
    }
    return _result;
  }
  factory SubscribeToFooEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeToFooEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeToFooEventsRequest clone() => SubscribeToFooEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeToFooEventsRequest copyWith(void Function(SubscribeToFooEventsRequest) updates) => super.copyWith((message) => updates(message as SubscribeToFooEventsRequest)) as SubscribeToFooEventsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeToFooEventsRequest create() => SubscribeToFooEventsRequest._();
  SubscribeToFooEventsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeToFooEventsRequest> createRepeated() => $pb.PbList<SubscribeToFooEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToFooEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeToFooEventsRequest>(create);
  static SubscribeToFooEventsRequest? _defaultInstance;

  SubscribeToFooEventsRequest_From whichFrom() => _SubscribeToFooEventsRequest_FromByTag[$_whichOneof(0)]!;
  void clearFrom() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $1.Empty get all => $_getN(1);
  @$pb.TagNumber(2)
  set all($1.Empty v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAll() => $_has(1);
  @$pb.TagNumber(2)
  void clearAll() => clearField(2);
  @$pb.TagNumber(2)
  $1.Empty ensureAll() => $_ensure(1);
}

class FooState1Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FooState1Request', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  FooState1Request._() : super();
  factory FooState1Request({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory FooState1Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FooState1Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FooState1Request clone() => FooState1Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FooState1Request copyWith(void Function(FooState1Request) updates) => super.copyWith((message) => updates(message as FooState1Request)) as FooState1Request; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FooState1Request create() => FooState1Request._();
  FooState1Request createEmptyInstance() => create();
  static $pb.PbList<FooState1Request> createRepeated() => $pb.PbList<FooState1Request>();
  @$core.pragma('dart2js:noInline')
  static FooState1Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FooState1Request>(create);
  static FooState1Request? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class FooState1Response_FooState1 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FooState1Response.FooState1', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  FooState1Response_FooState1._() : super();
  factory FooState1Response_FooState1({
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory FooState1Response_FooState1.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FooState1Response_FooState1.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FooState1Response_FooState1 clone() => FooState1Response_FooState1()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FooState1Response_FooState1 copyWith(void Function(FooState1Response_FooState1) updates) => super.copyWith((message) => updates(message as FooState1Response_FooState1)) as FooState1Response_FooState1; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FooState1Response_FooState1 create() => FooState1Response_FooState1._();
  FooState1Response_FooState1 createEmptyInstance() => create();
  static $pb.PbList<FooState1Response_FooState1> createRepeated() => $pb.PbList<FooState1Response_FooState1>();
  @$core.pragma('dart2js:noInline')
  static FooState1Response_FooState1 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FooState1Response_FooState1>(create);
  static FooState1Response_FooState1? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get author => $_getSZ(1);
  @$pb.TagNumber(2)
  set author($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => clearField(2);
}

class FooState1Response_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FooState1Response.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  FooState1Response_Error._() : super();
  factory FooState1Response_Error({
    $core.int? statusCode,
    $core.String? reasonPhrase,
  }) {
    final _result = create();
    if (statusCode != null) {
      _result.statusCode = statusCode;
    }
    if (reasonPhrase != null) {
      _result.reasonPhrase = reasonPhrase;
    }
    return _result;
  }
  factory FooState1Response_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FooState1Response_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FooState1Response_Error clone() => FooState1Response_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FooState1Response_Error copyWith(void Function(FooState1Response_Error) updates) => super.copyWith((message) => updates(message as FooState1Response_Error)) as FooState1Response_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FooState1Response_Error create() => FooState1Response_Error._();
  FooState1Response_Error createEmptyInstance() => create();
  static $pb.PbList<FooState1Response_Error> createRepeated() => $pb.PbList<FooState1Response_Error>();
  @$core.pragma('dart2js:noInline')
  static FooState1Response_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FooState1Response_Error>(create);
  static FooState1Response_Error? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get statusCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set statusCode($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatusCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatusCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reasonPhrase => $_getSZ(1);
  @$pb.TagNumber(2)
  set reasonPhrase($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReasonPhrase() => $_has(1);
  @$pb.TagNumber(2)
  void clearReasonPhrase() => clearField(2);
}

enum FooState1Response_Result {
  state, 
  error, 
  notSet
}

class FooState1Response extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FooState1Response_Result> _FooState1Response_ResultByTag = {
    1 : FooState1Response_Result.state,
    2 : FooState1Response_Result.error,
    0 : FooState1Response_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FooState1Response', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<FooState1Response_FooState1>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', subBuilder: FooState1Response_FooState1.create)
    ..aOM<FooState1Response_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: FooState1Response_Error.create)
    ..hasRequiredFields = false
  ;

  FooState1Response._() : super();
  factory FooState1Response({
    FooState1Response_FooState1? state,
    FooState1Response_Error? error,
  }) {
    final _result = create();
    if (state != null) {
      _result.state = state;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory FooState1Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FooState1Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FooState1Response clone() => FooState1Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FooState1Response copyWith(void Function(FooState1Response) updates) => super.copyWith((message) => updates(message as FooState1Response)) as FooState1Response; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FooState1Response create() => FooState1Response._();
  FooState1Response createEmptyInstance() => create();
  static $pb.PbList<FooState1Response> createRepeated() => $pb.PbList<FooState1Response>();
  @$core.pragma('dart2js:noInline')
  static FooState1Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FooState1Response>(create);
  static FooState1Response? _defaultInstance;

  FooState1Response_Result whichResult() => _FooState1Response_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  FooState1Response_FooState1 get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(FooState1Response_FooState1 v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);
  @$pb.TagNumber(1)
  FooState1Response_FooState1 ensureState() => $_ensure(0);

  @$pb.TagNumber(2)
  FooState1Response_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(FooState1Response_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  FooState1Response_Error ensureError() => $_ensure(1);
}

