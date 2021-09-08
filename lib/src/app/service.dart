import 'dart:async';

import 'package:eventuous/eventuous.dart';

part 'mixins/any.dart';
part 'mixins/base.dart';
part 'mixins/create.dart';
part 'mixins/update.dart';

/// Application service base class.
/// A derived class should be scoped to handle commands
/// for one aggregate type only.

/// Type parameter [TData] - [StreamEvent.data] content type
/// Type parameter [TEvent] - [Aggregate.changes] event type
/// Type parameter [TValue] - [AggregateState.value] type
/// Type parameter [TId] - [Aggregate.id] type
/// Type parameter [TState] - [AggregateState] type
/// Type parameter [TAggregate] - [Aggregate] type
///
abstract class ApplicationServiceBase<
        TData extends Object,
        TEvent extends Object,
        TValue extends Object,
        TId extends AggregateId,
        TState extends AggregateState<TValue>,
        TAggregate extends Aggregate<TEvent, TValue, TId, TState>>
    with
        ApplicationServiceMixin<TData, TEvent, TValue, TId, TState, TAggregate>,
        OnAnyAggregateMixin<TData, TEvent, TValue, TId, TState, TAggregate>,
        OnCreateAggregateMixin<TData, TEvent, TValue, TId, TState, TAggregate>,
        OnUpdateAggregateMixin<TData, TEvent, TValue, TId, TState, TAggregate> {
  ApplicationServiceBase(this.store);

  /// Get [AggregateStore] which this service operate on
  @override
  final AggregateStore<TData, TEvent, TValue, TId, TState, TAggregate> store;
}
