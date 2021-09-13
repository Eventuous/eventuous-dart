class Eventuous {
  const Eventuous({
    this.inferTypes = true,
  });

  /// Determines if parameterized types should be inferred from
  /// annotated classes. If true (default) the following
  /// [parameterized types](https://dart.dev/guides/language/language-tour#restricting-the-parameterized-type)
  /// are inferred by following introspections:
  ///
  /// * [TData] in [AggregateEventCreator] - inferred from additional
  /// annotations. Is restricted to type [Object] (inferred if
  /// not annotated with JsonSerializable).
  /// ```dart
  /// @JsonSerializable() // => infers TData is JsonMap,
  /// @AggregateEventType()
  /// class FooCreated extends _$FooCreated {}
  /// ```
  ///
  /// * [TId] in [Aggregate] - inferred from name of aggregate class.
  /// Is restricted to type [AggregateId].
  /// ```dart
  /// @AggregateType() // => infers TId is FooId
  /// class Foo extends _$Foo {}
  /// class FooId {}
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
  /// * [AggregateEventAnnotation] - defines aggregate event types
  /// * [AggregateStateAnnotation] - defines aggregate state types
  /// * [AggregateValueAnnotation] - defines aggregate (state) value types
  /// * [AggregateCommandAnnotation] - defines aggregate command types
  ///
  final bool inferTypes;
}

const eventuousAnnotation = Eventuous();
