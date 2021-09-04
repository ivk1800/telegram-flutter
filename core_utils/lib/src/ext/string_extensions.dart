extension StringExtensions on String? {
  String orEmpty() => this ?? '';

  String? takeIfNotEmpty() => this?.isNotEmpty ?? false ? this : null;
}
