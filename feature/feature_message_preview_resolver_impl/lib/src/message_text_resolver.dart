import 'package:tdlib/td_api.dart' as td;

class MessageTextResolver {
  Future<String> resolve(td.MessageContent content) async {
    return content.maybeMap(
      messageAnimation: (_) {
        return 'GIF';
      },
      messageText: (td.MessageText value) {
        return value.text.text;
      },
      orElse: () {
        return content.runtimeType.toString();
      },
    );
  }
}
