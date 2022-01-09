import 'package:rich_text_format/rich_text_format.dart';
import 'package:td_rich_text_parser/td_rich_text_parser.dart';
import 'package:tdlib/td_api.dart' as td;

class FormattedTextResolver {
  FormattedTextResolver({
    required Parser parser,
  }) : _parser = parser;

  final Parser _parser;

  RichText? resolve(td.FormattedText text) {
    if (text.text.isEmpty) {
      return null;
    }
    final List<Entity> entities = _parser.parse(text);
    assert(entities.isNotEmpty);
    return RichText(entities: entities);
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
