// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'example.dart';

// **************************************************************************
// EventuousGenerator
// **************************************************************************

abstract class _$Example extends Aggregate<JsonObject, ExampleStateModel1,
    ExampleId1, ExampleState1> {
  _$Example(ExampleId1 id, ExampleState1? state)
      : super(id, state ?? ExampleState1());
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
