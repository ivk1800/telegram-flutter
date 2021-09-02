library rich_text_format;

abstract class RichText {
  String get source;
}

class PlainText implements RichText {
  PlainText({required this.text});

  final String text;

  @override
  String get source => text;
}
