import 'package:eventuous/eventuous.dart';

class WrongExpectedVersionException extends StreamException {
  WrongExpectedVersionException(ExpectedStreamVersion expected, int actual)
      : super('Wrong stream version: expected $expected, actual was $actual');
}
