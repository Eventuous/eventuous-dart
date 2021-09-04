import 'package:eventuate/eventuate.dart';

/// [AggregateStateStore] store loads [AggregateState] from any source.
///
/// This class implements [AggregateStateCreator] as default method.
///
/// Type parameter [S] - [AggregateState.value] type
/// Type parameter [T] - [AggregateState] type
///
class AggregateStateStore<S, T extends AggregateState<S>> {
  /// Default constructor. If [onNew] is not given,
  /// [AggregateStateCreator] must be registered with
  /// [AggregateStateTypeMap.addType], or method
  /// [newInstance] must be overridden.
  ///
  AggregateStateStore({
    AggregateStateCreator<S, T>? onNew,
  }) : _onNew = onNew {
    //
    // Sanity checks
    //
    if (_onNew == null && !AggregateStateTypeMap.contains<S, T>()) {
      throw UnimplementedError('newInstance is not implemented');
    }
  }

  /// [AggregateStateCreator] instance
  final AggregateStateCreator<S, T>? _onNew;

  /// [AggregateStateCreator] implementation
  T call([S? value]) => newInstance(value);

  /// Create new [AggregateState] instance with
  /// [AggregateState.value] of [S]. If [value]
  /// is not given, a default value is used.
  T newInstance([S? value]) {
    return _onNew == null
        ? AggregateStateTypeMap.create<S, T>(value)
        : _onNew!(value);
  }

  /// Load [AggregateState] of type [T] for given [StreamName].
  Future<T> load(StreamName name) async {
    return newInstance();
  }
}
