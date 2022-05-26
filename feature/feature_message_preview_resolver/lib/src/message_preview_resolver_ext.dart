import 'package:tdlib/td_api.dart' as td;

import 'message_preview_data.dart';
import 'message_preview_resolver.dart';

extension MessagePreviewResolverExt on IMessagePreviewResolver {
  Future<MessagePreviewData> resolveFromChatOrEmpty(td.Chat chat) async {
    final td.Message? message = chat.lastMessage;
    if (message == null) {
      return const MessagePreviewData();
    }
    return resolve(message);
  }
}
