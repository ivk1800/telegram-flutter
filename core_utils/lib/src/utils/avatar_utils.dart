// todo improve
String getAvatarAbbreviation({
  required String first,
  required String second,
}) {
  String f = '';
  String l = '';

  final String firstTrimmed = first.trim();
  if (firstTrimmed.isNotEmpty) {
    f = firstTrimmed[0];
  }

  final String secondTrimmed = second.trim();
  if (secondTrimmed.isNotEmpty) {
    l = secondTrimmed[0];
  }

  return (f + l).toUpperCase().trim();
}
