import 'exceptions.dart';

class Ensure {
  static TAggregate notNull<TAggregate>(TAggregate? value, String name) {
    if (value != null) {
      return value;
    }
    throw ArgumentNullOrEmptyException(name, true);
  }

  static String notEmptyString(String? value, String name) {
    if (value?.isNotEmpty == true) {
      return value!;
    }
    throw ArgumentNullOrEmptyException(name, value == null);
  }
}
