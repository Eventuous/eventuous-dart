import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bar.dart';

part 'bar_events.g.dart';

@JsonSerializable()
@AggregateEventType(Bar, data: JsonMap)
class BarCreated extends _$BarCreated {
  BarCreated({
    required this.barId,
    required this.title,
    required this.author,
  }) : super([barId, title, author]);
  final String barId;
  final String title;
  final String author;
}

@JsonSerializable()
@AggregateEventType(Bar, data: JsonMap)
class BarUpdated extends _$BarUpdated {
  BarUpdated(this.barId, this.title, this.author)
      : super([barId, title, author]);
  final String barId;
  final String title;
  final String? author;
}

@JsonSerializable()
@AggregateEventType(Bar, data: JsonMap)
class BarImported extends _$BarImported {
  BarImported(this.barId, this.title, [this.author])
      : super([barId, title, author]);
  final String barId;
  final String title;
  final String? author;
}
