library example;

import 'package:eventuous/eventuous.dart';
import 'package:get_it/get_it.dart';

import 'src/bar/bar.dart';
import 'src/bar/bar_app.dart';
import 'src/foo.dart';

part 'test_lib.g.dart';

@Eventuous(
  initializerName: r'_$configureEventuous',
)
void configureEventuous(StreamEventStore eventStore) =>
    _$configureEventuous(eventStore);
