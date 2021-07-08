import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class ChatPreviewDataResolver {
  @j.inject
  ChatPreviewDataResolver({
    required IUserRepository userRepository,
    required ILocalizationManager localizationManager,
  })  : _localizationManager = localizationManager,
        _userRepository = userRepository;

  final IUserRepository _userRepository;
  final ILocalizationManager _localizationManager;

  Future<ChatPreviewData> resolve(td.Chat chat) async {
    final td.Message? message = chat.lastMessage;
    if (message == null) {
      return const ChatPreviewData();
    }

    final td.MessageContent content = message.content;
    switch (content.getConstructor()) {
      case td.MessageText.CONSTRUCTOR:
        {
          final td.MessageText m = content as td.MessageText;
          if (message.sender is td.MessageSenderUser) {
            final td.MessageSenderUser senderUser =
                message.sender as td.MessageSenderUser;
            final td.User user =
                await _userRepository.getUser(senderUser.userId);
            return ChatPreviewData(
                firstText: user.firstName, secondText: m.text.text);
          }
          return ChatPreviewData(firstText: null, secondText: m.text.text);
        }
      case td.MessageSticker.CONSTRUCTOR:
        {
          final td.MessageSticker m = content as td.MessageSticker;
          return ChatPreviewData(
              firstText: 'Sticker', secondText: m.sticker.emoji);
        }
      case td.MessagePhoto.CONSTRUCTOR:
        {
          final td.MessagePhoto m = content as td.MessagePhoto;
          return ChatPreviewData(
              firstText: 'Photo', secondText: m.caption.text);
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
          return ChatPreviewData(
              firstText: _localizationManager.getStringFormatted(
                  'EventLogGroupJoined', <dynamic>[joinedUsernames]),
              secondText: null);
        }
      case td.MessageDocument.CONSTRUCTOR:
        {
          final td.MessageDocument m = content as td.MessageDocument;
          return ChatPreviewData(
              firstText: '📎 ${m.caption.text}', secondText: null);
        }
    }

    return ChatPreviewData(
        firstText: null, secondText: content.runtimeType.toString());
  }
}

class ChatPreviewData {
  const ChatPreviewData({this.firstText, this.secondText});

  final String? firstText;

  final String? secondText;
}
