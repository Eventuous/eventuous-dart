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
  final BarAuthor? author;
}

@JsonSerializable()
class BarAuthor extends JsonObject {
  BarAuthor(this.fname, this.lname) : super([fname, lname]);

  final String fname;
  final String lname;

  static BarAuthor fromJson([JsonMap? json]) => _$BarAuthorFromJson(json ?? {});

  @override
  JsonMap toJson() => _$BarAuthorToJson(this);
}
