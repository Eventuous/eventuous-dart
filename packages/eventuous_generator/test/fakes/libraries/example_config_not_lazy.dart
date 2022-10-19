import 'package:eventuous/eventuous.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_lib/example.dart';

part 'eventuous.g.dart';

final getIt = GetIt.instance;

@Eventuous(lazyService: false)
void initEventuous() => _$initEventuous(getId);