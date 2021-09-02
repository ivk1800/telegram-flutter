library rich_text_format_flutter;

import 'package:flutter/rendering.dart';
import 'package:rich_text_format/rich_text_format.dart';

extension RichTextExt on RichText {
  InlineSpan toInlineSpan() {
    return TextSpan(text: source);
  }
}
