// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventuous.dart';

// **************************************************************************
// ConfigGenerator
// **************************************************************************

void _$configureEventuous(GetIt getIt) {
  $Eventuous.init();
}

typedef EventuousInitCallback = void Function();

class $Eventuous {
  static final _callbacks = <EventuousInitCallback>{};
  static void init() {
    for (var callback in _callbacks) {
      callback();
    }
  }

  static void onInit(EventuousInitCallback callback) =>
      _callbacks.add(callback);
}
