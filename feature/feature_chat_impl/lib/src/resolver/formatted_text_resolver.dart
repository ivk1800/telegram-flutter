import 'package:rich_text_format/rich_text_format.dart';
import 'package:tdlib/td_api.dart' as td;

class FormattedTextResolver {
  RichText? resolve(td.FormattedText text) {
    if (text.text.isEmpty) {
      return null;
    }

    return PlainText(text: text.text);
  }
}

extension FormattedTextResolverExt on FormattedTextResolver {
  RichText? resolveOrNull(td.FormattedText? text) {
    if (text == null) {
      return null;
    }
    return resolve(text);
  }
}
