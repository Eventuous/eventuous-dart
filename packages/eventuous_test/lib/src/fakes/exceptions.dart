import 'package:eventuous/eventuous.dart';

class WrongExpectedVersionException extends StreamException {
  WrongExpectedVersionException(this.expectedVersion, this.actualVersion)
      : super(
          'Wrong stream version: expected '
          '$expectedVersion, actual was $actualVersion',
        );

  final int actualVersion;
  final ExpectedStreamVersion expectedVersion;
}
