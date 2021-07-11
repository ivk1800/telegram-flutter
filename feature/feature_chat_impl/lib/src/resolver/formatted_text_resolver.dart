import 'package:flutter/rendering.dart';
import 'package:tdlib/td_api.dart' as td;

class FormattedTextResolver {
  InlineSpan? resolve(td.FormattedText text) {
    if (text.text.isEmpty) {
      return null;
    }
    return TextSpan(text: text.text);
  }
}
