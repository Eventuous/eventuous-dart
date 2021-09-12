import 'package:eventstore_client/eventstore_client.dart';
import 'package:eventuous/eventuous.dart';

extension ExpectedStreamVersionX on ExpectedStreamVersion {
  StreamRevision asStreamRevision() => StreamRevision.checked(value);
}

extension StreamTruncatePositionX on StreamTruncatePosition {
  StreamPosition asStreamPosition() => StreamPosition.checked(value);
}

extension StreamReadPositionX on StreamReadPosition {
  StreamPosition asStreamPosition({bool forward = true}) => value == -1
      ? forward
          ? StreamPosition.start
          : StreamPosition.end
      : StreamPosition.checked(value);
}
