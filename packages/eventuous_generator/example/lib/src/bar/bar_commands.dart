import 'package:eventuous/eventuous.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bar.dart';
import 'bar_events.dart';

part 'bar_commands.g.dart';

/// Doc CreateBar
@JsonSerializable()
@AggregateCommandType(Bar, BarCreated, expected: ExpectedState.notExists)
class CreateBar extends _$CreateBar {
  CreateBar({
    required this.barId,
    required this.title,
    required this.author,
  }) : super([barId, title, author]);

  /// Doc barId
  final String barId;

  /// Doc title
  final String title;

  /// Doc author
  final String author;
}

@JsonSerializable()
@AggregateCommandType(Bar, BarUpdated, expected: ExpectedState.exists)
class UpdateBar extends _$UpdateBar {
  UpdateBar(this.barId, this.title, String? author)
      : _author = author,
        super([barId, title, author]);
  final String barId;
  final String title;

  /// Doc author getter
  String? get author => _author;

  final String? _author;
}

@JsonSerializable()
@AggregateCommandType(Bar, BarImported)
class ImportBar extends _$ImportBar {
  ImportBar(this.barId, this.title, [this.author = 'user'])
      : super([barId, title, author]);
  final String barId;
  final String title;
  final String? author;
}
