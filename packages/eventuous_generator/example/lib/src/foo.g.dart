// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foo.dart';

// **************************************************************************
// AggregateGenerator
// **************************************************************************

abstract class _$Foo
    extends Aggregate<JsonObject, FooStateModel1, FooId1, FooState1> {
  _$Foo(FooId1 id, FooState1? state) : super(id, state ?? FooState1()) {
    AggregateTypes.define<JsonObject, FooStateModel1, FooId1, FooState1, Foo>(
      (id, [state]) => Foo(id, state),
    );
  }
  // ignore: unused_element
  static Foo from(String id) => Foo(FooId1(id));
}

// **************************************************************************
// AggregateEventGenerator
// **************************************************************************

abstract class _$FooCreated extends JsonObject {
  _$FooCreated(List<Object?> props) : super(props) {
    AggregateEventTypes.define<JsonMap, FooCreated>(
      _$FooCreated.fromJson,
    );
  }

  static FooCreated fromJson(JsonMap json) => _$FooCreatedFromJson(json);

  @override
  JsonMap toJson() => _$FooCreatedToJson(this as FooCreated);
}

// **************************************************************************
// AggregateValueGenerator
// **************************************************************************

abstract class _$FooStateModel1 extends JsonObject {
  _$FooStateModel1(List<Object?> props) : super(props) {
    AggregateValueTypes.define<JsonMap, FooStateModel1>(
      _$FooStateModel1.fromJson,
    );
  }

  static FooStateModel1 fromJson([JsonMap? json]) =>
      _$FooStateModel1FromJson(json ?? {});

  @override
  JsonMap toJson() => _$FooStateModel1ToJson(this as FooStateModel1);
}

// **************************************************************************
// AggregateStateGenerator
// **************************************************************************

abstract class _$FooState1 extends AggregateState<FooStateModel1> {
  _$FooState1(FooStateModel1? value, int? version)
      : super(value ?? FooStateModel1(), version) {
    AggregateStateTypes.define<FooStateModel1, FooState1>(
      ([value, version]) => FooState1(value, version),
    );
    on<FooCreated>(patch);
  }

  FooState1 patch(JsonObject event, FooStateModel1 value) {
    return FooState1(AggregateValueTypes.create<JsonMap, FooStateModel1>(
      JsonUtils.patch(
        value,
        event,
      ),
    ));
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FooStateModel1 _$FooStateModel1FromJson(Map<String, dynamic> json) =>
    FooStateModel1(
      title: json['title'] as String?,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$FooStateModel1ToJson(FooStateModel1 instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };

CreateFoo _$CreateFooFromJson(Map<String, dynamic> json) => CreateFoo(
      json['title'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$CreateFooToJson(CreateFoo instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };

FooCreated _$FooCreatedFromJson(Map<String, dynamic> json) => FooCreated(
      json['title'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$FooCreatedToJson(FooCreated instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };
