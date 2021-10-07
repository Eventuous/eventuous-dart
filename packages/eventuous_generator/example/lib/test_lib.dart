library example;

import 'package:eventuous/eventuous.dart';
import 'package:get_it/get_it.dart';

part 'test_lib.g.dart';

final getIt = GetIt.instance;

@Eventuous(
  initializerName: r'_$configureEventuous',
)
void configureEventuous() => _$configureEventuous(getIt);
