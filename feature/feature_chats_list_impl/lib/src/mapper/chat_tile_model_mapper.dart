import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper({
    required DateFormatter dateFormatter,
    required DateParser dateParser,
    required IMessagePreviewResolver previewDataResolver,
    required IChatRepository chatRepository,
  })  : _dateFormatter = dateFormatter,
        _messagePreviewResolver = previewDataResolver,
        _chatRepository = chatRepository,
        _dateParser = dateParser;

  final IChatRepository _chatRepository;
  final IMessagePreviewResolver _messagePreviewResolver;
  final DateFormatter _dateFormatter;
  final DateParser _dateParser;

  Future<ChatTileModel> mapToModel(td.Chat chat) async {
    final MessagePreviewData preview =
        await _messagePreviewResolver.resolveFromChatOrEmpty(chat);

    assert(chat.positions.length == 1);
    return ChatTileModel(
      isMuted: chat.notificationSettings.muteFor > 0,
      isVerified: await getVerified(chat),
      unreadMessagesCount: chat.unreadCount,
      isPinned: chat.positions[0].isPinned,
      isMentioned: chat.unreadMentionCount > 0,
      lastMessageDate: _dateFormatter.formatChatLastMessageDateOrNull(
        _dateParser.parseUnixTimeStampToDateOrNull(chat.lastMessage?.date),
      ),
      id: chat.id,
      photoId: chat.photo?.small.id,
      title: chat.title,
      firstSubtitle: preview.firstText,
      secondSubtitle: preview.secondText,
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

  String createForFormattedText(td.FormattedText text) {
    return text.text;
  }
}
