import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:tdlib/td_api.dart' as td;

import 'message_text_resolver.dart';
import 'preview_delegate.dart';

class ChatPreviewDelegate implements IPreviewDelegate {
  const ChatPreviewDelegate({
    required MessageTextResolver messageTextResolver,
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        _messageTextResolver = messageTextResolver;

  final IUserRepository _userRepository;
  final MessageTextResolver _messageTextResolver;

  @override
  Future<MessagePreviewData> resolveForAnimation(
    td.Message message,
    td.MessageAnimation animation,
  ) =>
      _resolve(message.sender, animation);

  @override
  Future<MessagePreviewData> resolveForText(
    td.Message message,
    td.MessageText text,
  ) async {
    return MessagePreviewData(
      firstText: await _getSenderNameToDisplay(message.sender),
      secondText: await _messageTextResolver.resolve(text),
    );
  }

  Future<String?> _getSenderNameToDisplay(td.MessageSender sender) async {
    switch (sender.getConstructor()) {
      case td.MessageSenderUser.CONSTRUCTOR:
        {
          final td.User user = await _userRepository
              .getUser((sender as td.MessageSenderUser).userId);
          return '${user.firstName} ${user.lastName}';
        }
    }
    return null;
  }

  Future<MessagePreviewData> _resolve(
    td.MessageSender sender,
    td.MessageAnimation animation,
  ) async {
    final String? senderName = await _getSenderNameToDisplay(sender);
    final String messageText = await _messageTextResolver.resolve(animation);
    return MessagePreviewData(
      firstText: senderName ?? messageText,
      secondText: senderName != null ? messageText : null,
    );
  }
}
