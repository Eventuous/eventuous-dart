import 'package:eventuous/eventuous.dart';

/// Eventuous
///
/// * [AggregateType] - defines aggregate
/// * [AggregateIdType] - defines aggregate ids
/// * [AggregateEventType] - defines aggregate events
/// * [AggregateStateType] - defines aggregate states
/// * [AggregateValueType] - defines aggregate (state) values
/// * [AggregateCommandType] - defines aggregate commands
/// * [ApplicationType] - defines internal app service for an aggregate
/// * [GrpcServiceType] - defines external grpc service for an app service

/// Determines if parameterized types should be inferred from
/// annotated classes. If true (default) the following
/// [parameterized types](https://dart.dev/guides/language/language-tour#restricting-the-parameterized-type)
/// are inferred by following introspections. If false, default naming
/// conventions are used instead if applicable, or restricted to default type otherwise.
///
/// * [TId] in [AggregateType] - inferred from name of aggregate class.
/// Is restricted to type [AggregateId] (default naming).
/// ```dart
/// @AggregateType()
/// class Foo extends _$Foo {}
/// @AggregateType(Foo) // => infers TId is FooId
/// class FooId {}
/// ```
///
/// * [TData] in [AggregateType] - inferred from additional annotations and
/// used in [AggregateEventCreator] to create [TEvent]s from [TData].
/// Is restricted to type [Object] (default naming).
/// ```dart
/// @AggregateType()
/// class Foo extends _$Foo {}
/// @JsonSerializable() // => infers TData is JsonMap,
/// @AggregateEventType(Foo) // => links FooCreated with Foo
/// class FooCreated extends _$FooCreated {}
/// ```
///
/// * [TState] in [Aggregate] - inferred from name of aggregate class.
/// Is restricted to type [AggregateState<TValue>].
/// ```dart
/// @AggregateType() // => infers TState is FooState
/// class Foo extends _$Foo {}
/// @AggregateStateType(Foo)
/// class FooState extends _$FooState {}
/// ```
///
/// * [TValue] in [AggregateState] - inferred from name of aggregate class
/// Is restricted to type [Object].
/// ```dart
/// @AggregateType() // => infers TValue is FooValue
/// class Foo extends _$Foo {}
/// class FooValue {}
/// @AggregateStateType(Foo) // => infers TValue is FooValue
/// class FooState extends _$FooState {}
/// ```
///
/// When false, the limiting type of parameterized types
/// like [TValue] in [AggregateState] is used if not explicitly
/// specified with given annotations:
///
///
class Eventuous {
  const Eventuous({
    bool? inferTypes,
    bool? lazyService,
    String? initializerName,
  })  : inspectPath = inspectPathDefault,
        inspectPattern = inspectPatternDefault,
        inferTypes = inferTypes ?? inferTypesDefault,
        lazyService = lazyService ?? lazyServiceDefault,
        initializerName = initializerName ?? initializerNameDefault;

  static const inferTypesField = 'infer_types';
  static const lazyServiceField = 'lazy_service';
  static const inspectPathField = 'inspect_path';
  static const inspectPatternField = 'inspect_pattern';
  static const initializerNameField = 'initializer_name';

  static const inferTypesDefault = true;
  static const lazyServiceDefault = true;
  static const inspectPathDefault = r'$lib$';
  static const inspectPatternDefault = '**.dart';
  static const initializerNameDefault = r'_$initEventuous';

  const Eventuous._({
    bool? inferTypes,
    bool? lazyService,
    String? inspectPath,
    String? inspectPattern,
    String? initializerName,
  })  : inferTypes = inferTypes ?? inferTypesDefault,
        lazyService = lazyService ?? lazyServiceDefault,
        inspectPath = inspectPath ?? inspectPathDefault,
        inspectPattern = inspectPattern ?? inspectPatternDefault,
        initializerName = initializerName ?? initializerNameDefault;

  /// Input path for code inspection
  final String inspectPath;

  /// Input pattern for code inspection
  final String inspectPattern;

  /// Name of the generated initializer method
  final String initializerName;

  final bool inferTypes;

  /// Application services are registered lazily
  final bool lazyService;

  factory Eventuous.fromJson(JsonMap json) => Eventuous._(
        inferTypes: (json[inferTypesField] ?? inferTypesDefault) as bool,
        lazyService: (json[lazyServiceField] ?? lazyServiceDefault) as bool,
        inspectPath: (json[inspectPathField] ?? inspectPathDefault) as String,
        inspectPattern:
            (json[inspectPatternField] ?? inspectPatternDefault) as String,
        initializerName:
            (json[initializerNameField] ?? initializerNameDefault) as String,
      );

  JsonMap toJson() => {
        inferTypesField: inferTypes,
        lazyServiceField: lazyService,
        inspectPathField: inspectPath,
        inspectPatternField: inspectPattern,
        initializerNameField: initializerName,
      };
}

const eventuous = Eventuous();
