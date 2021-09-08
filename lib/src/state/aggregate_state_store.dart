import 'package:eventuous/eventuous.dart';

/// Base class for loading [AggregateState] from any source.
///
/// This class implements [AggregateStateCreator] as default method.
///
/// Type parameter [TValue] - [AggregateState.value] type
/// Type parameter [TState] - [AggregateState] type
///
abstract class AggregateStateStore<TValue extends Object,
    TState extends AggregateState<TValue>> {
  /// Default constructor. If [onNew] is not given,
  /// [AggregateStateCreator] must be registered with
  /// [AggregateStateType.addType], or method
  /// [newInstance] must be overridden.
  ///
  AggregateStateStore({
    AggregateStateCreator<TValue, TState>? onNew,
  }) : _onNew = onNew {
    //
    // Sanity checks
    //
    if (_onNew == null && !AggregateStateType.containsType(typeOf<TState>())) {
      throw UnimplementedError('newInstance is not implemented');
    }
  }

  /// [AggregateStateCreator] instance
  final AggregateStateCreator<TValue, TState>? _onNew;

  /// [AggregateStateCreator] implementation
  TState call([TValue? value]) => newInstance(value);

  /// Create new [AggregateState] instance with
  /// [AggregateState.value] of [TValue]. If [value]
  /// is not given, a default value is used.
  TState newInstance([TValue? value]) {
    return _onNew == null
        ? AggregateStateType.create<TValue, TState>(value)
        : _onNew!(value);
  }

  /// Load [AggregateState] of type [TState] for given [StreamName].
  Future<TState> load(StreamName name);

  /// Save [AggregateState] of type [TState] for given [StreamName].
  Future<void> save(StreamName name, TState state);
}
