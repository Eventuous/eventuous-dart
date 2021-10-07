import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bar.dart';

part 'bar_commands.g.dart';

@JsonSerializable()
@AggregateCommandType(Bar)
class CreateBar extends _$CreateBar {
  CreateBar(this.title, this.author) : super([title, author]);
  final String title;
  final String author;
}
