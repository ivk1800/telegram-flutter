import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tuple/tuple.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper(
      {required DateFormatter dateFormatter,
      required IUserRepository userRepository,
      required DateParser dateParser,
      required ILocalizationManager localizationManager,
      required IChatRepository chatRepository})
      : _dateFormatter = dateFormatter,
        _userRepository = userRepository,
        _localizationManager = localizationManager,
        _chatRepository = chatRepository,
        _dateParser = dateParser;

  final IChatRepository _chatRepository;
  final IUserRepository _userRepository;
  final ILocalizationManager _localizationManager;
  final DateFormatter _dateFormatter;
  final DateParser _dateParser;

  Future<ChatTileModel> mapToModel(td.Chat chat) async {
    final Tuple2<String?, String?> subtitles = await _getSubtitles(chat);

    assert(chat.positions.length == 1);
    return ChatTileModel(
      isMuted: chat.notificationSettings.muteFor > 0,
      isVerified: await getVerified(chat),
      unreadMessagesCount: chat.unreadCount,
      isPinned: chat.positions[0].isPinned,
      lastMessageDate: _dateFormatter.formatChatLastMessageDateOrNull(
          _dateParser.parseUnixTimeStampToDateOrNull(chat.lastMessage?.date)),
      id: chat.id,
      photoId: chat.photo?.small.id,
      title: chat.title,
      firstSubtitle: subtitles.item1,
      secondSubtitle: subtitles.item2,
    );
  }

  Future<bool> getVerified(td.Chat chat) async {
    if (chat.type.getConstructor() == td.ChatTypeSupergroup.CONSTRUCTOR) {
      final td.ChatTypeSupergroup supergroupType =
          chat.type as td.ChatTypeSupergroup;
      return (await _chatRepository.getSupergroup(supergroupType.supergroupId))
          .isVerified;
    }
    return false;
  }

  Future<Tuple2<String?, String?>> _getSubtitles(td.Chat chat) async {
    final td.Message? message = chat.lastMessage;
    if (message == null) {
      return const Tuple2<String?, String?>(null, null);
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
            return Tuple2<String?, String?>(user.firstName, m.text.text);
          }
          return Tuple2<String?, String?>(null, m.text.text);
        }
      case td.MessageSticker.CONSTRUCTOR:
        {
          final td.MessageSticker m = content as td.MessageSticker;
          return Tuple2<String?, String?>('Sticker', m.sticker.emoji);
        }
      case td.MessagePhoto.CONSTRUCTOR:
        {
          final td.MessagePhoto m = content as td.MessagePhoto;
          return Tuple2<String?, String?>('Photo', m.caption.text);
        }
      case td.MessageChatAddMembers.CONSTRUCTOR:
        {
          final td.MessageChatAddMembers m =
              content as td.MessageChatAddMembers;
          final Iterable<Future<String>> userNamesFutures =
              m.memberUserIds.map((int userId) async {
            final td.User user = await _userRepository.getUser(userId);
            return '${user.firstName} ${user.lastName}';
          });
          final String joinedUsernames = await Future.wait(userNamesFutures)
              .then((List<String> users) => users.join(', '));
          return Tuple2<String?, String?>(
              _localizationManager.getStringFormatted(
                  'EventLogGroupJoined', <dynamic>[joinedUsernames]),
              null);
        }
      case td.MessageDocument.CONSTRUCTOR:
        {
          final td.MessageDocument m = content as td.MessageDocument;
          return Tuple2<String?, String?>('📎 ${m.caption.text}', null);
        }
    }

    return Tuple2<String?, String?>(null, content.runtimeType.toString());
  }

  String? _getFirstSubtitle(td.Chat chat) {
    return null;
  }

  String _createForMessageText(td.MessageText message) {
    return message.text.text;
  }

  String _createForMessageSticker(td.MessageSticker message) {
    return message.sticker.emoji;
  }

  String _createForMessagePhoto(td.MessagePhoto message) {
    return message.caption.text;
  }

  String createForFormattedText(td.FormattedText text) {
    return text.text;
  }
}
