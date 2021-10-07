import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bar.dart';

part 'bar_value.g.dart';

@JsonSerializable()
@AggregateValueType(Bar, data: JsonMap)
class BarValue extends _$BarValue {
  BarValue({
    this.title,
    this.author,
  }) : super([title, author]);
  final String? title;
  final String? author;
}
