import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:tdlib/td_api.dart' as td;

import 'message_text_resolver.dart';
import 'preview_delegate.dart';

class ReplyPreviewDelegate implements IPreviewDelegate {
  const ReplyPreviewDelegate({
    required IChatMessageRepository messageRepository,
    required IChatRepository chatRepository,
    required MessageTextResolver messageTextResolver,
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        _messageTextResolver = messageTextResolver,
        _messageRepository = messageRepository,
        _chatRepository = chatRepository;

  final MessageTextResolver _messageTextResolver;
  final IUserRepository _userRepository;
  final IChatRepository _chatRepository;
  final IChatMessageRepository _messageRepository;

  @override
  Future<MessagePreviewData> resolveForAnimation(
    td.Message message,
    td.MessageAnimation animation,
  ) async {
    return MessagePreviewData(
      firstText: await _getSenderNameToDisplay(message.senderId),
      secondText: 'GIF',
    );
  }

  @override
  Future<MessagePreviewData> resolveForText(
    td.Message message,
    td.MessageText text,
  ) async {
    return MessagePreviewData(
      firstText: await _getSenderNameToDisplay(message.senderId),
      secondText: await _messageTextResolver.resolve(message.content),
    );
  }

  Future<String> _getSenderNameToDisplay(td.MessageSender sender) async {
    switch (sender.getConstructor()) {
      case td.MessageSenderUser.CONSTRUCTOR:
        {
          final td.User user = await _userRepository
              .getUser((sender as td.MessageSenderUser).userId);
          return '${user.firstName} ${user.lastName}';
        }
      case td.MessageSenderChat.CONSTRUCTOR:
        {
          final td.Chat chat = await _chatRepository
              .getChat((sender as td.MessageSenderChat).chatId);
          return chat.title;
        }
    }
    return '';
  }
}
