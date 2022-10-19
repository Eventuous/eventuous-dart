///
//  Generated code. Do not modify.
//  source: bar/bar_app.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/empty.pb.dart' as $1;

class CreateBarRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateBarRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barId', protoName: 'barId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  CreateBarRequest._() : super();
  factory CreateBarRequest({
    $core.String? barId,
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (barId != null) {
      _result.barId = barId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory CreateBarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateBarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateBarRequest clone() => CreateBarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateBarRequest copyWith(void Function(CreateBarRequest) updates) => super.copyWith((message) => updates(message as CreateBarRequest)) as CreateBarRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateBarRequest create() => CreateBarRequest._();
  CreateBarRequest createEmptyInstance() => create();
  static $pb.PbList<CreateBarRequest> createRepeated() => $pb.PbList<CreateBarRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateBarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBarRequest>(create);
  static CreateBarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barId => $_getSZ(0);
  @$pb.TagNumber(1)
  set barId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarId() => clearField(1);

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

class CreateBarResponse_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateBarResponse.Success', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CreateBarResponse_Success._() : super();
  factory CreateBarResponse_Success() => create();
  factory CreateBarResponse_Success.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateBarResponse_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateBarResponse_Success clone() => CreateBarResponse_Success()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateBarResponse_Success copyWith(void Function(CreateBarResponse_Success) updates) => super.copyWith((message) => updates(message as CreateBarResponse_Success)) as CreateBarResponse_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateBarResponse_Success create() => CreateBarResponse_Success._();
  CreateBarResponse_Success createEmptyInstance() => create();
  static $pb.PbList<CreateBarResponse_Success> createRepeated() => $pb.PbList<CreateBarResponse_Success>();
  @$core.pragma('dart2js:noInline')
  static CreateBarResponse_Success getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBarResponse_Success>(create);
  static CreateBarResponse_Success? _defaultInstance;
}

class CreateBarResponse_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateBarResponse.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  CreateBarResponse_Error._() : super();
  factory CreateBarResponse_Error({
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
  factory CreateBarResponse_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateBarResponse_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateBarResponse_Error clone() => CreateBarResponse_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateBarResponse_Error copyWith(void Function(CreateBarResponse_Error) updates) => super.copyWith((message) => updates(message as CreateBarResponse_Error)) as CreateBarResponse_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateBarResponse_Error create() => CreateBarResponse_Error._();
  CreateBarResponse_Error createEmptyInstance() => create();
  static $pb.PbList<CreateBarResponse_Error> createRepeated() => $pb.PbList<CreateBarResponse_Error>();
  @$core.pragma('dart2js:noInline')
  static CreateBarResponse_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBarResponse_Error>(create);
  static CreateBarResponse_Error? _defaultInstance;

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

enum CreateBarResponse_Result {
  success, 
  error, 
  notSet
}

class CreateBarResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, CreateBarResponse_Result> _CreateBarResponse_ResultByTag = {
    1 : CreateBarResponse_Result.success,
    2 : CreateBarResponse_Result.error,
    0 : CreateBarResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateBarResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<CreateBarResponse_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success', subBuilder: CreateBarResponse_Success.create)
    ..aOM<CreateBarResponse_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: CreateBarResponse_Error.create)
    ..hasRequiredFields = false
  ;

  CreateBarResponse._() : super();
  factory CreateBarResponse({
    CreateBarResponse_Success? success,
    CreateBarResponse_Error? error,
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
  factory CreateBarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateBarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateBarResponse clone() => CreateBarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateBarResponse copyWith(void Function(CreateBarResponse) updates) => super.copyWith((message) => updates(message as CreateBarResponse)) as CreateBarResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateBarResponse create() => CreateBarResponse._();
  CreateBarResponse createEmptyInstance() => create();
  static $pb.PbList<CreateBarResponse> createRepeated() => $pb.PbList<CreateBarResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateBarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBarResponse>(create);
  static CreateBarResponse? _defaultInstance;

  CreateBarResponse_Result whichResult() => _CreateBarResponse_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  CreateBarResponse_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(CreateBarResponse_Success v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  CreateBarResponse_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateBarResponse_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(CreateBarResponse_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  CreateBarResponse_Error ensureError() => $_ensure(1);
}

class UpdateBarRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBarRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barId', protoName: 'barId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  UpdateBarRequest._() : super();
  factory UpdateBarRequest({
    $core.String? barId,
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (barId != null) {
      _result.barId = barId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory UpdateBarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBarRequest clone() => UpdateBarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBarRequest copyWith(void Function(UpdateBarRequest) updates) => super.copyWith((message) => updates(message as UpdateBarRequest)) as UpdateBarRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBarRequest create() => UpdateBarRequest._();
  UpdateBarRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateBarRequest> createRepeated() => $pb.PbList<UpdateBarRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateBarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBarRequest>(create);
  static UpdateBarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barId => $_getSZ(0);
  @$pb.TagNumber(1)
  set barId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarId() => clearField(1);

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

class UpdateBarResponse_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBarResponse.Success', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  UpdateBarResponse_Success._() : super();
  factory UpdateBarResponse_Success() => create();
  factory UpdateBarResponse_Success.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBarResponse_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBarResponse_Success clone() => UpdateBarResponse_Success()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBarResponse_Success copyWith(void Function(UpdateBarResponse_Success) updates) => super.copyWith((message) => updates(message as UpdateBarResponse_Success)) as UpdateBarResponse_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBarResponse_Success create() => UpdateBarResponse_Success._();
  UpdateBarResponse_Success createEmptyInstance() => create();
  static $pb.PbList<UpdateBarResponse_Success> createRepeated() => $pb.PbList<UpdateBarResponse_Success>();
  @$core.pragma('dart2js:noInline')
  static UpdateBarResponse_Success getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBarResponse_Success>(create);
  static UpdateBarResponse_Success? _defaultInstance;
}

class UpdateBarResponse_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBarResponse.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  UpdateBarResponse_Error._() : super();
  factory UpdateBarResponse_Error({
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
  factory UpdateBarResponse_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBarResponse_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBarResponse_Error clone() => UpdateBarResponse_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBarResponse_Error copyWith(void Function(UpdateBarResponse_Error) updates) => super.copyWith((message) => updates(message as UpdateBarResponse_Error)) as UpdateBarResponse_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBarResponse_Error create() => UpdateBarResponse_Error._();
  UpdateBarResponse_Error createEmptyInstance() => create();
  static $pb.PbList<UpdateBarResponse_Error> createRepeated() => $pb.PbList<UpdateBarResponse_Error>();
  @$core.pragma('dart2js:noInline')
  static UpdateBarResponse_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBarResponse_Error>(create);
  static UpdateBarResponse_Error? _defaultInstance;

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

enum UpdateBarResponse_Result {
  success, 
  error, 
  notSet
}

class UpdateBarResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, UpdateBarResponse_Result> _UpdateBarResponse_ResultByTag = {
    1 : UpdateBarResponse_Result.success,
    2 : UpdateBarResponse_Result.error,
    0 : UpdateBarResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBarResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<UpdateBarResponse_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success', subBuilder: UpdateBarResponse_Success.create)
    ..aOM<UpdateBarResponse_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: UpdateBarResponse_Error.create)
    ..hasRequiredFields = false
  ;

  UpdateBarResponse._() : super();
  factory UpdateBarResponse({
    UpdateBarResponse_Success? success,
    UpdateBarResponse_Error? error,
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
  factory UpdateBarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBarResponse clone() => UpdateBarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBarResponse copyWith(void Function(UpdateBarResponse) updates) => super.copyWith((message) => updates(message as UpdateBarResponse)) as UpdateBarResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBarResponse create() => UpdateBarResponse._();
  UpdateBarResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateBarResponse> createRepeated() => $pb.PbList<UpdateBarResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateBarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBarResponse>(create);
  static UpdateBarResponse? _defaultInstance;

  UpdateBarResponse_Result whichResult() => _UpdateBarResponse_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  UpdateBarResponse_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(UpdateBarResponse_Success v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  UpdateBarResponse_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  UpdateBarResponse_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(UpdateBarResponse_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  UpdateBarResponse_Error ensureError() => $_ensure(1);
}

class ImportBarRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportBarRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barId', protoName: 'barId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author')
    ..hasRequiredFields = false
  ;

  ImportBarRequest._() : super();
  factory ImportBarRequest({
    $core.String? barId,
    $core.String? title,
    $core.String? author,
  }) {
    final _result = create();
    if (barId != null) {
      _result.barId = barId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (author != null) {
      _result.author = author;
    }
    return _result;
  }
  factory ImportBarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportBarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportBarRequest clone() => ImportBarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportBarRequest copyWith(void Function(ImportBarRequest) updates) => super.copyWith((message) => updates(message as ImportBarRequest)) as ImportBarRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportBarRequest create() => ImportBarRequest._();
  ImportBarRequest createEmptyInstance() => create();
  static $pb.PbList<ImportBarRequest> createRepeated() => $pb.PbList<ImportBarRequest>();
  @$core.pragma('dart2js:noInline')
  static ImportBarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportBarRequest>(create);
  static ImportBarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get barId => $_getSZ(0);
  @$pb.TagNumber(1)
  set barId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBarId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBarId() => clearField(1);

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

class ImportBarResponse_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportBarResponse.Success', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ImportBarResponse_Success._() : super();
  factory ImportBarResponse_Success() => create();
  factory ImportBarResponse_Success.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportBarResponse_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportBarResponse_Success clone() => ImportBarResponse_Success()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportBarResponse_Success copyWith(void Function(ImportBarResponse_Success) updates) => super.copyWith((message) => updates(message as ImportBarResponse_Success)) as ImportBarResponse_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportBarResponse_Success create() => ImportBarResponse_Success._();
  ImportBarResponse_Success createEmptyInstance() => create();
  static $pb.PbList<ImportBarResponse_Success> createRepeated() => $pb.PbList<ImportBarResponse_Success>();
  @$core.pragma('dart2js:noInline')
  static ImportBarResponse_Success getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportBarResponse_Success>(create);
  static ImportBarResponse_Success? _defaultInstance;
}

class ImportBarResponse_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportBarResponse.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  ImportBarResponse_Error._() : super();
  factory ImportBarResponse_Error({
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
  factory ImportBarResponse_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportBarResponse_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportBarResponse_Error clone() => ImportBarResponse_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportBarResponse_Error copyWith(void Function(ImportBarResponse_Error) updates) => super.copyWith((message) => updates(message as ImportBarResponse_Error)) as ImportBarResponse_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportBarResponse_Error create() => ImportBarResponse_Error._();
  ImportBarResponse_Error createEmptyInstance() => create();
  static $pb.PbList<ImportBarResponse_Error> createRepeated() => $pb.PbList<ImportBarResponse_Error>();
  @$core.pragma('dart2js:noInline')
  static ImportBarResponse_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportBarResponse_Error>(create);
  static ImportBarResponse_Error? _defaultInstance;

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

enum ImportBarResponse_Result {
  success, 
  error, 
  notSet
}

class ImportBarResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ImportBarResponse_Result> _ImportBarResponse_ResultByTag = {
    1 : ImportBarResponse_Result.success,
    2 : ImportBarResponse_Result.error,
    0 : ImportBarResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImportBarResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<ImportBarResponse_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success', subBuilder: ImportBarResponse_Success.create)
    ..aOM<ImportBarResponse_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: ImportBarResponse_Error.create)
    ..hasRequiredFields = false
  ;

  ImportBarResponse._() : super();
  factory ImportBarResponse({
    ImportBarResponse_Success? success,
    ImportBarResponse_Error? error,
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
  factory ImportBarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportBarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportBarResponse clone() => ImportBarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportBarResponse copyWith(void Function(ImportBarResponse) updates) => super.copyWith((message) => updates(message as ImportBarResponse)) as ImportBarResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImportBarResponse create() => ImportBarResponse._();
  ImportBarResponse createEmptyInstance() => create();
  static $pb.PbList<ImportBarResponse> createRepeated() => $pb.PbList<ImportBarResponse>();
  @$core.pragma('dart2js:noInline')
  static ImportBarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportBarResponse>(create);
  static ImportBarResponse? _defaultInstance;

  ImportBarResponse_Result whichResult() => _ImportBarResponse_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  ImportBarResponse_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(ImportBarResponse_Success v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  ImportBarResponse_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  ImportBarResponse_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(ImportBarResponse_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  ImportBarResponse_Error ensureError() => $_ensure(1);
}

class BarId1Event extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarId1Event', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  BarId1Event._() : super();
  factory BarId1Event({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory BarId1Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarId1Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarId1Event clone() => BarId1Event()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarId1Event copyWith(void Function(BarId1Event) updates) => super.copyWith((message) => updates(message as BarId1Event)) as BarId1Event; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarId1Event create() => BarId1Event._();
  BarId1Event createEmptyInstance() => create();
  static $pb.PbList<BarId1Event> createRepeated() => $pb.PbList<BarId1Event>();
  @$core.pragma('dart2js:noInline')
  static BarId1Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarId1Event>(create);
  static BarId1Event? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class BarEvent_BarState_BarAuthor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarEvent.BarState.BarAuthor', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fname')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lname')
    ..hasRequiredFields = false
  ;

  BarEvent_BarState_BarAuthor._() : super();
  factory BarEvent_BarState_BarAuthor({
    $core.String? fname,
    $core.String? lname,
  }) {
    final _result = create();
    if (fname != null) {
      _result.fname = fname;
    }
    if (lname != null) {
      _result.lname = lname;
    }
    return _result;
  }
  factory BarEvent_BarState_BarAuthor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarEvent_BarState_BarAuthor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarEvent_BarState_BarAuthor clone() => BarEvent_BarState_BarAuthor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarEvent_BarState_BarAuthor copyWith(void Function(BarEvent_BarState_BarAuthor) updates) => super.copyWith((message) => updates(message as BarEvent_BarState_BarAuthor)) as BarEvent_BarState_BarAuthor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarEvent_BarState_BarAuthor create() => BarEvent_BarState_BarAuthor._();
  BarEvent_BarState_BarAuthor createEmptyInstance() => create();
  static $pb.PbList<BarEvent_BarState_BarAuthor> createRepeated() => $pb.PbList<BarEvent_BarState_BarAuthor>();
  @$core.pragma('dart2js:noInline')
  static BarEvent_BarState_BarAuthor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarEvent_BarState_BarAuthor>(create);
  static BarEvent_BarState_BarAuthor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fname => $_getSZ(0);
  @$pb.TagNumber(1)
  set fname($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFname() => $_has(0);
  @$pb.TagNumber(1)
  void clearFname() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lname => $_getSZ(1);
  @$pb.TagNumber(2)
  set lname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLname() => $_has(1);
  @$pb.TagNumber(2)
  void clearLname() => clearField(2);
}

class BarEvent_BarState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarEvent.BarState', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOM<BarEvent_BarState_BarAuthor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author', subBuilder: BarEvent_BarState_BarAuthor.create)
    ..hasRequiredFields = false
  ;

  BarEvent_BarState._() : super();
  factory BarEvent_BarState({
    $core.String? title,
    BarEvent_BarState_BarAuthor? author,
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
  factory BarEvent_BarState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarEvent_BarState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarEvent_BarState clone() => BarEvent_BarState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarEvent_BarState copyWith(void Function(BarEvent_BarState) updates) => super.copyWith((message) => updates(message as BarEvent_BarState)) as BarEvent_BarState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarEvent_BarState create() => BarEvent_BarState._();
  BarEvent_BarState createEmptyInstance() => create();
  static $pb.PbList<BarEvent_BarState> createRepeated() => $pb.PbList<BarEvent_BarState>();
  @$core.pragma('dart2js:noInline')
  static BarEvent_BarState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarEvent_BarState>(create);
  static BarEvent_BarState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  BarEvent_BarState_BarAuthor get author => $_getN(1);
  @$pb.TagNumber(2)
  set author(BarEvent_BarState_BarAuthor v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => clearField(2);
  @$pb.TagNumber(2)
  BarEvent_BarState_BarAuthor ensureAuthor() => $_ensure(1);
}

class BarEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarEvent', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<BarEvent_BarState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', subBuilder: BarEvent_BarState.create)
    ..hasRequiredFields = false
  ;

  BarEvent._() : super();
  factory BarEvent({
    $core.String? id,
    BarEvent_BarState? state,
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
  factory BarEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarEvent clone() => BarEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarEvent copyWith(void Function(BarEvent) updates) => super.copyWith((message) => updates(message as BarEvent)) as BarEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarEvent create() => BarEvent._();
  BarEvent createEmptyInstance() => create();
  static $pb.PbList<BarEvent> createRepeated() => $pb.PbList<BarEvent>();
  @$core.pragma('dart2js:noInline')
  static BarEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarEvent>(create);
  static BarEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  BarEvent_BarState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(BarEvent_BarState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
  @$pb.TagNumber(2)
  BarEvent_BarState ensureState() => $_ensure(1);
}

enum SubscribeToBarEventsRequest_From {
  id, 
  all, 
  notSet
}

class SubscribeToBarEventsRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SubscribeToBarEventsRequest_From> _SubscribeToBarEventsRequest_FromByTag = {
    1 : SubscribeToBarEventsRequest_From.id,
    2 : SubscribeToBarEventsRequest_From.all,
    0 : SubscribeToBarEventsRequest_From.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeToBarEventsRequest', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$1.Empty>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'all', subBuilder: $1.Empty.create)
    ..hasRequiredFields = false
  ;

  SubscribeToBarEventsRequest._() : super();
  factory SubscribeToBarEventsRequest({
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
  factory SubscribeToBarEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeToBarEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeToBarEventsRequest clone() => SubscribeToBarEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeToBarEventsRequest copyWith(void Function(SubscribeToBarEventsRequest) updates) => super.copyWith((message) => updates(message as SubscribeToBarEventsRequest)) as SubscribeToBarEventsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeToBarEventsRequest create() => SubscribeToBarEventsRequest._();
  SubscribeToBarEventsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeToBarEventsRequest> createRepeated() => $pb.PbList<SubscribeToBarEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToBarEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeToBarEventsRequest>(create);
  static SubscribeToBarEventsRequest? _defaultInstance;

  SubscribeToBarEventsRequest_From whichFrom() => _SubscribeToBarEventsRequest_FromByTag[$_whichOneof(0)]!;
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

class BarStateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarStateRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  BarStateRequest._() : super();
  factory BarStateRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory BarStateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarStateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarStateRequest clone() => BarStateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarStateRequest copyWith(void Function(BarStateRequest) updates) => super.copyWith((message) => updates(message as BarStateRequest)) as BarStateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarStateRequest create() => BarStateRequest._();
  BarStateRequest createEmptyInstance() => create();
  static $pb.PbList<BarStateRequest> createRepeated() => $pb.PbList<BarStateRequest>();
  @$core.pragma('dart2js:noInline')
  static BarStateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarStateRequest>(create);
  static BarStateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class BarStateResponse_BarState_BarAuthor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarStateResponse.BarState.BarAuthor', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fname')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lname')
    ..hasRequiredFields = false
  ;

  BarStateResponse_BarState_BarAuthor._() : super();
  factory BarStateResponse_BarState_BarAuthor({
    $core.String? fname,
    $core.String? lname,
  }) {
    final _result = create();
    if (fname != null) {
      _result.fname = fname;
    }
    if (lname != null) {
      _result.lname = lname;
    }
    return _result;
  }
  factory BarStateResponse_BarState_BarAuthor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarStateResponse_BarState_BarAuthor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarStateResponse_BarState_BarAuthor clone() => BarStateResponse_BarState_BarAuthor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarStateResponse_BarState_BarAuthor copyWith(void Function(BarStateResponse_BarState_BarAuthor) updates) => super.copyWith((message) => updates(message as BarStateResponse_BarState_BarAuthor)) as BarStateResponse_BarState_BarAuthor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarStateResponse_BarState_BarAuthor create() => BarStateResponse_BarState_BarAuthor._();
  BarStateResponse_BarState_BarAuthor createEmptyInstance() => create();
  static $pb.PbList<BarStateResponse_BarState_BarAuthor> createRepeated() => $pb.PbList<BarStateResponse_BarState_BarAuthor>();
  @$core.pragma('dart2js:noInline')
  static BarStateResponse_BarState_BarAuthor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarStateResponse_BarState_BarAuthor>(create);
  static BarStateResponse_BarState_BarAuthor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fname => $_getSZ(0);
  @$pb.TagNumber(1)
  set fname($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFname() => $_has(0);
  @$pb.TagNumber(1)
  void clearFname() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lname => $_getSZ(1);
  @$pb.TagNumber(2)
  set lname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLname() => $_has(1);
  @$pb.TagNumber(2)
  void clearLname() => clearField(2);
}

class BarStateResponse_BarState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarStateResponse.BarState', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOM<BarStateResponse_BarState_BarAuthor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author', subBuilder: BarStateResponse_BarState_BarAuthor.create)
    ..hasRequiredFields = false
  ;

  BarStateResponse_BarState._() : super();
  factory BarStateResponse_BarState({
    $core.String? title,
    BarStateResponse_BarState_BarAuthor? author,
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
  factory BarStateResponse_BarState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarStateResponse_BarState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarStateResponse_BarState clone() => BarStateResponse_BarState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarStateResponse_BarState copyWith(void Function(BarStateResponse_BarState) updates) => super.copyWith((message) => updates(message as BarStateResponse_BarState)) as BarStateResponse_BarState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarStateResponse_BarState create() => BarStateResponse_BarState._();
  BarStateResponse_BarState createEmptyInstance() => create();
  static $pb.PbList<BarStateResponse_BarState> createRepeated() => $pb.PbList<BarStateResponse_BarState>();
  @$core.pragma('dart2js:noInline')
  static BarStateResponse_BarState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarStateResponse_BarState>(create);
  static BarStateResponse_BarState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  BarStateResponse_BarState_BarAuthor get author => $_getN(1);
  @$pb.TagNumber(2)
  set author(BarStateResponse_BarState_BarAuthor v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => clearField(2);
  @$pb.TagNumber(2)
  BarStateResponse_BarState_BarAuthor ensureAuthor() => $_ensure(1);
}

class BarStateResponse_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarStateResponse.Error', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusCode', $pb.PbFieldType.O3, protoName: 'statusCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reasonPhrase', protoName: 'reasonPhrase')
    ..hasRequiredFields = false
  ;

  BarStateResponse_Error._() : super();
  factory BarStateResponse_Error({
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
  factory BarStateResponse_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarStateResponse_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarStateResponse_Error clone() => BarStateResponse_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarStateResponse_Error copyWith(void Function(BarStateResponse_Error) updates) => super.copyWith((message) => updates(message as BarStateResponse_Error)) as BarStateResponse_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarStateResponse_Error create() => BarStateResponse_Error._();
  BarStateResponse_Error createEmptyInstance() => create();
  static $pb.PbList<BarStateResponse_Error> createRepeated() => $pb.PbList<BarStateResponse_Error>();
  @$core.pragma('dart2js:noInline')
  static BarStateResponse_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarStateResponse_Error>(create);
  static BarStateResponse_Error? _defaultInstance;

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

enum BarStateResponse_Result {
  state, 
  error, 
  notSet
}

class BarStateResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BarStateResponse_Result> _BarStateResponse_ResultByTag = {
    1 : BarStateResponse_Result.state,
    2 : BarStateResponse_Result.error,
    0 : BarStateResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BarStateResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<BarStateResponse_BarState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', subBuilder: BarStateResponse_BarState.create)
    ..aOM<BarStateResponse_Error>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: BarStateResponse_Error.create)
    ..hasRequiredFields = false
  ;

  BarStateResponse._() : super();
  factory BarStateResponse({
    BarStateResponse_BarState? state,
    BarStateResponse_Error? error,
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
  factory BarStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BarStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BarStateResponse clone() => BarStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BarStateResponse copyWith(void Function(BarStateResponse) updates) => super.copyWith((message) => updates(message as BarStateResponse)) as BarStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BarStateResponse create() => BarStateResponse._();
  BarStateResponse createEmptyInstance() => create();
  static $pb.PbList<BarStateResponse> createRepeated() => $pb.PbList<BarStateResponse>();
  @$core.pragma('dart2js:noInline')
  static BarStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BarStateResponse>(create);
  static BarStateResponse? _defaultInstance;

  BarStateResponse_Result whichResult() => _BarStateResponse_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  BarStateResponse_BarState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BarStateResponse_BarState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);
  @$pb.TagNumber(1)
  BarStateResponse_BarState ensureState() => $_ensure(0);

  @$pb.TagNumber(2)
  BarStateResponse_Error get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(BarStateResponse_Error v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  BarStateResponse_Error ensureError() => $_ensure(1);
}

