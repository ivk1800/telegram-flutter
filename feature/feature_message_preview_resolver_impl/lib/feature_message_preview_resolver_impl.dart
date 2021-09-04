library feature_message_preview_resolver_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:feature_message_preview_resolver_impl/chat_preview_delegate.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;

import 'message_text_resolver.dart';
import 'preview_delegate.dart';
import 'reply_preview_delegate.dart';

enum Mode {
  ChatPreview,
  ReplyPreview,
}

class MessagePreviewResolver implements IMessagePreviewResolver {
  MessagePreviewResolver({
    required Mode mode,
    required IUserRepository userRepository,
    required IChatMessageRepository messageRepository,
    required IChatRepository chatRepository,
    required ILocalizationManager localizationManager,
  })  : _localizationManager = localizationManager,
        _userRepository = userRepository,
        _delegate = mode == Mode.ChatPreview
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
  final ILocalizationManager _localizationManager;
  final IPreviewDelegate _delegate;

  @override
  Future<MessagePreviewData> resolve(td.Message message) async {
    final td.MessageContent content = message.content;
    switch (content.getConstructor()) {
      case td.MessageText.CONSTRUCTOR:
        {
          return _delegate.resolveForText(message, content as td.MessageText);
        }
      case td.MessageSticker.CONSTRUCTOR:
        {
          final td.MessageSticker m = content as td.MessageSticker;
          return MessagePreviewData(
            firstText: 'Sticker',
            secondText: m.sticker.emoji,
          );
        }
      case td.MessagePhoto.CONSTRUCTOR:
        {
          final td.MessagePhoto m = content as td.MessagePhoto;
          return MessagePreviewData(
            firstText: 'Photo',
            secondText: m.caption.text,
          );
        }
      case td.MessageChatAddMembers.CONSTRUCTOR:
        {
          final td.MessageChatAddMembers m =
              content as td.MessageChatAddMembers;
          final Iterable<Future<String>> userNamesFutures =
              m.memberUserIds.map((int userId) async {
            final td.User user = await _userRepository.getUser(userId);
            return <String>[user.firstName, user.lastName].join(', ');
          });
          final String joinedUsernames = await Future.wait(userNamesFutures)
              .then((List<String> users) => users.join(', '));
          return MessagePreviewData(
            firstText: _localizationManager.getStringFormatted(
              'EventLogGroupJoined',
              <dynamic>[joinedUsernames],
            ),
            secondText: null,
          );
        }
      case td.MessageDocument.CONSTRUCTOR:
        {
          final td.MessageDocument m = content as td.MessageDocument;
          return MessagePreviewData(
            firstText: '📎 ${m.caption.text}',
            secondText: null,
          );
        }
      case td.MessageAnimation.CONSTRUCTOR:
        {
          return _delegate.resolveForAnimation(
            message,
            content as td.MessageAnimation,
          );
        }
    }

    return MessagePreviewData(
      firstText: null,
      secondText: content.runtimeType.toString(),
    );
  }
}
