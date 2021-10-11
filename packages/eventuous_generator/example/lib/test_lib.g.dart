// GENERATED CODE - DO NOT MODIFY BY HAND

part of example;

// **************************************************************************
// ConfigGenerator
// **************************************************************************

GetIt _$configureEventuous(StreamEventStore eventStore) {
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<FooApp>(
    () => FooApp(FooStore(
      eventStore,
      onNew: (id, [state]) => Foo(id, state),
    )),
  );
  getIt.registerLazySingleton<BarApp>(
    () => BarApp(BarStore(
      eventStore,
      onNew: (id, [state]) => Bar(id, state),
    )),
  );

  return getIt;
}
