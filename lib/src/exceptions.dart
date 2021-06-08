import 'package:eventuate/eventuate.dart';

import 'aggregate.dart';
import 'stream_name.dart';

class StreamException implements Exception {
  StreamException(this.message);
  final String message;
  @override
  String toString() => "$runtimeType: '$message'";
}

class StreamNotFound extends StreamException {
  StreamNotFound(StreamName stream) : super('Stream $stream not found');

  factory StreamNotFound.from(String name) => StreamNotFound(StreamName(name));
}

class WrongExpectedVersion extends StreamException {
  WrongExpectedVersion(ExpectedStreamVersion expected, int actual)
      : super('Wrong stream version: expected $expected, actual was $actual');
}

class DomainException implements Exception {
  DomainException(this.message);
  final String message;
  @override
  String toString() => "$runtimeType: '$message'";
}

class AggregateNotFound<T extends Aggregate> extends DomainException {
  AggregateNotFound(String id)
      : super(
          'Aggregate ${typeOf<T>()} $id not found '
          'in stream ${StreamName.fromId<T>(id)}',
        );
}

class AggregateExists<T extends Aggregate> extends DomainException {
  AggregateExists(String id)
      : super(
          'Aggregate ${typeOf<T>()} $id exists already '
          'in stream ${StreamName.fromId<T>(id)}',
        );
}
