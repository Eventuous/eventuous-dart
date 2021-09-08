import 'package:eventuous/eventuous.dart';

class StreamException implements Exception {
  StreamException(this.message);
  final String message;
  @override
  String toString() => "$runtimeType: '$message'";
}

class StreamNotFoundException extends StreamException {
  StreamNotFoundException(StreamName stream)
      : super("Stream '$stream' not found");

  factory StreamNotFoundException.from(StreamName name) =>
      StreamNotFoundException(name);
}

class DomainException implements Exception {
  DomainException(this.message);
  final String message;
  @override
  String toString() => "$runtimeType: '$message'";
}

class UnknownEventException extends DomainException {
  UnknownEventException(
    Type type, [
    this.cause,
  ]) : super("Event '$type' is unknown. $cause");

  final Object? cause;
}

class AggregateNotFoundException extends DomainException {
  AggregateNotFoundException(
    Type type,
    AggregateId id, [
    this.cause,
  ]) : super(
          "Aggregate $type '$id' not found "
          'in stream ${StreamName.fromId(type, id)}',
        );

  final Object? cause;
}

class AggregateExistsException extends DomainException {
  AggregateExistsException(
    Type type,
    AggregateId id, [
    this.cause,
  ]) : super(
          "Aggregate $type '$id' exists already "
          'in stream ${StreamName.fromId(type, id)}',
        );
  final Object? cause;
}

class CommandHandlerNotFoundException extends DomainException {
  CommandHandlerNotFoundException(
    Type type,
  ) : super("Handler not found for command '$type'");
}

/// The [ArgumentException] is thrown when an argument
///  is null when it shouldn't be.
class ArgumentNullOrEmptyException implements Exception {
  ArgumentNullOrEmptyException(this.name, this.isNull);
  final String name;
  final bool isNull;
  bool get isEmpty => !isNull;
  String get message => "Argument '$name' is ${isNull ? 'null' : 'empty'}";

  @override
  String toString() {
    return '$runtimeType{name: $name, message: $message}';
  }
}
