extension TypeX on Type {
  /// Convert [Type] into lower case string
  String toLowerCase() {
    return '${this}'.toLowerCase();
  }

  /// Convert [Type] into colon delimited lower case string
  String toColonCase() {
    return '${this}'.toColonCase();
  }

  /// Convert [Type] into kebab case string
  String toKebabCase() {
    return '${this}'.toKebabCase();
  }

  /// Convert [Type] into delimited lower case string
  String toDelimiterCase(String delimiter) {
    return '${this}'.toDelimiterCase(delimiter);
  }
}

extension StringX on String {
  /// Convert [String] into colon delimited lower case string
  String toColonCase() {
    return toDelimiterCase(':');
  }

  /// Convert [String] into kebab case string
  String toKebabCase() {
    return toDelimiterCase('-');
  }

  /// Convert [String] into delimited lower case string
  String toDelimiterCase(String delimiter) {
    return split(RegExp('(?<=[a-z0-9])(?=[A-Z0-9])'))
        .join(delimiter)
        .toLowerCase();
  }
}
