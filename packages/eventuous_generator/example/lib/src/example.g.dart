// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// CodeGenerator
// **************************************************************************

abstract class _$Example extends Aggregate<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1> {
  _$Example(ExampleId1 id, ExampleState1? state)
      : super(id, state ?? ExampleState1());
  // ignore: unused_element
  static Example from(String id) => Example(ExampleId1(id));
}

abstract class _$ExampleStateModel1 extends JsonObject {
  _$ExampleStateModel1(List<Object?> props) : super(props);

  static ExampleStateModel1 fromJson(JsonMap json) =>
      _$ExampleStateModel1FromJson(json);

  @override
  JsonMap toJson() => _$ExampleStateModel1ToJson(this as ExampleStateModel1);
}

abstract class _$ExampleState1 extends AggregateState<ExampleStateModel1> {
  _$ExampleState1(ExampleStateModel1? value, int? version)
      : super(value ?? ExampleStateModel1(), version) {
    on<ExampleCreated>(patch);
  }
  ExampleState1 patch(JsonObject event, ExampleStateModel1 value) {
    return ExampleState1(_$ExampleStateModel1.fromJson(JsonUtils.patch(
      value,
      event,
    )));
  }
}

abstract class _$ExampleCreated extends JsonObject {
  _$ExampleCreated(List<Object?> props) : super(props);

  static ExampleCreated fromJson(JsonMap json) =>
      _$ExampleCreatedFromJson(json);

  @override
  JsonMap toJson() => _$ExampleCreatedToJson(this as ExampleCreated);
}

void defineExampleTypes() {
  AggregateTypes.define<JsonObject, ExampleStateModel1, ExampleId1,
      ExampleState1, Example>((id, [state]) => Example(id, state));
  AggregateStateTypes.define<ExampleStateModel1, ExampleState1>(
    ([value, version]) => ExampleState1(value, version),
  );
  AggregateEventTypes.define<JsonMap, ExampleCreated>(
    (data) => _$ExampleCreated.fromJson(data),
  );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleStateModel1 _$ExampleStateModel1FromJson(Map<String, dynamic> json) =>
    ExampleStateModel1(
      title: json['title'] as String?,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$ExampleStateModel1ToJson(ExampleStateModel1 instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };

ExampleCreated _$ExampleCreatedFromJson(Map<String, dynamic> json) =>
    ExampleCreated(
      json['title'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$ExampleCreatedToJson(ExampleCreated instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };
