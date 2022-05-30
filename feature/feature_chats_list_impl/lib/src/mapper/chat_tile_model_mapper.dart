import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:shared_models/shared_models.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper({
    required DateFormatter dateFormatter,
    required DateParser dateParser,
    required IMessagePreviewResolver previewDataResolver,
    required ISuperGroupRepository superGroupRepository,
  })  : _dateFormatter = dateFormatter,
        _messagePreviewResolver = previewDataResolver,
        _superGroupRepository = superGroupRepository,
        _dateParser = dateParser;

  final ISuperGroupRepository _superGroupRepository;
  final IMessagePreviewResolver _messagePreviewResolver;
  final DateFormatter _dateFormatter;
  final DateParser _dateParser;

  Future<ChatTileModel> mapToModel(td.Chat chat) async {
    final MessagePreviewData preview =
        await _messagePreviewResolver.resolveFromChatOrEmpty(chat);

    assert(chat.positions.length == 1);
    final bool isSecret =
        chat.type.getConstructor() == td.ChatTypeSecret.constructor;
    return ChatTileModel(
      isMuted: chat.notificationSettings.muteFor > 0,
      isVerified: await getVerified(chat),
      unreadMessagesCount: chat.unreadCount,
      isPinned: chat.positions[0].isPinned,
      isRead: null,
      isSecret: isSecret,
      isMentioned: chat.unreadMentionCount > 0,
      lastMessageDate: _dateFormatter.formatChatLastMessageDateOrNull(
        _dateParser.parseUnixTimeStampToDateOrNull(chat.lastMessage?.date),
      ),
      id: chat.id,
      avatar: Avatar(
        abbreviation: getAvatarAbbreviation(first: chat.title, second: ''),
        objectId: chat.id,
        minithumbnail: chat.photo?.minithumbnail?.toMinithumbnail(),
        imageFileId: chat.photo?.small.id,
      ),
      title: chat.title,
      firstSubtitle: preview.firstText,
      secondSubtitle: preview.secondText,
    );
  }

  Future<bool> getVerified(td.Chat chat) async {
    if (chat.type.getConstructor() == td.ChatTypeSupergroup.constructor) {
      final td.ChatTypeSupergroup supergroupType =
          chat.type as td.ChatTypeSupergroup;
      return (await _superGroupRepository.getGroup(supergroupType.supergroupId))
          .isVerified;
    }
    return false;
  }

  String createForFormattedText(td.FormattedText text) {
    return text.text;
  }
}
