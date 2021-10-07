import 'package:eventuous/eventuous.dart';
import 'package:get_it/get_it.dart';

part 'eventuous.g.dart';

final getIt = GetIt.instance;

@Eventuous(
  initializerName: r'_$configureEventuous',
)
void configureEventuous() => _$configureEventuous(getIt);
