import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bar.dart';

part 'bar_events.g.dart';

@JsonSerializable()
@AggregateEventType(Bar, data: JsonMap)
class BarCreated extends _$BarCreated {
  BarCreated(this.title, this.author) : super([title, author]);
  final String title;
  final String author;
}
