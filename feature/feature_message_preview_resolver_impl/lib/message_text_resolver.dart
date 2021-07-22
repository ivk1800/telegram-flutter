import 'package:tdlib/td_api.dart' as td;

class MessageTextResolver {
  Future<String> resolve(td.MessageContent content) async {
    switch (content.getConstructor()) {
      case td.MessageAnimation.CONSTRUCTOR:
        {
          return 'GIF';
        }
      case td.MessageText.CONSTRUCTOR:
        {
          final td.MessageText c = content as td.MessageText;
          return c.text.text;
        }
    }

    return content.runtimeType.toString();
  }
}
