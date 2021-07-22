library feature_message_preview_resolver_api;

import 'package:tdlib/td_api.dart' as td;

abstract class IMessagePreviewResolver {
  Future<MessagePreviewData> resolve(td.Message message);
}

class MessagePreviewData {
  const MessagePreviewData({this.firstText, this.secondText});

  final String? firstText;

  final String? secondText;
}

extension MessagePreviewResolverExt on IMessagePreviewResolver {
  Future<MessagePreviewData> resolveFromChatOrEmpty(td.Chat chat) async {
    final td.Message? message = chat.lastMessage;
    if (message == null) {
      return const MessagePreviewData();
    }
    return resolve(message);
  }
}
