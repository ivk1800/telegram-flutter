extension StringExtensions on String? {
  String orEmpty() => this ?? '';

  String? takeIfNotEmpty() => this?.isNotEmpty == true ? this : null;
}
