library feature_message_preview_resolver_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:feature_message_preview_resolver_impl/src/chat_preview_delegate.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;

import 'message_text_resolver.dart';
import 'mode.dart';
import 'preview_delegate.dart';
import 'reply_preview_delegate.dart';

class MessagePreviewResolver implements IMessagePreviewResolver {
  MessagePreviewResolver({
    required Mode mode,
    required IUserRepository userRepository,
    required IChatMessageRepository messageRepository,
    required IChatRepository chatRepository,
    required IStringsProvider stringsProvider,
  })  : _stringsProvider = stringsProvider,
        _userRepository = userRepository,
        _delegate = mode == Mode.chatPreview
            ? ChatPreviewDelegate(
                messageTextResolver: MessageTextResolver(),
                userRepository: userRepository,
              )
            : ReplyPreviewDelegate(
                messageRepository: messageRepository,
                messageTextResolver: MessageTextResolver(),
                userRepository: userRepository,
                chatRepository: chatRepository,
              );

  final IUserRepository _userRepository;
  final IStringsProvider _stringsProvider;
  final IPreviewDelegate _delegate;

  @override
  Future<MessagePreviewData> resolve(td.Message message) async {
    final td.MessageContent content = message.content;
    return content.maybeMap(
      messageText: (td.MessageText value) {
        return _delegate.resolveForText(message, value);
      },
      messageSticker: (td.MessageSticker value) {
        return MessagePreviewData(
          firstText: 'Sticker',
          secondText: value.sticker.emoji,
        );
      },
      messagePhoto: (td.MessagePhoto value) {
        return MessagePreviewData(
          firstText: 'Photo',
          secondText: value.caption.text,
        );
      },
      messageChatAddMembers: (td.MessageChatAddMembers value) async {
        final Iterable<Future<String>> userNamesFutures =
            value.memberUserIds.map((int userId) async {
          final td.User user = await _userRepository.getUser(userId);
          return <String>[user.firstName, user.lastName].join(', ');
        });
        final String joinedUsernames = await Future.wait(userNamesFutures)
            .then((List<String> users) => users.join(', '));
        return MessagePreviewData(
          firstText:
              _stringsProvider.eventLogGroupJoined(<dynamic>[joinedUsernames]),
        );
      },
      messageDocument: (td.MessageDocument value) {
        return MessagePreviewData(
          firstText: '📎 ${value.caption.text}',
        );
      },
      messageAnimation: (td.MessageAnimation value) {
        return _delegate.resolveForAnimation(
          message,
          value,
        );
      },
      orElse: () {
        return MessagePreviewData(
          secondText: content.runtimeType.toString(),
        );
      },
    );
  }
}
