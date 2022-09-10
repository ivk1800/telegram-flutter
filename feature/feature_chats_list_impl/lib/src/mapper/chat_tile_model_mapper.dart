import 'package:core_presentation/core_presentation.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/src/list/chat_ext.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_api/td_api.dart' as td;

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper({
    required DateFormatter dateFormatter,
    required DateParser dateParser,
    required IMessagePreviewResolver previewDataResolver,
    required ISuperGroupRepository superGroupRepository,
    required AvatarResolver avatarResolver,
  })  : _dateFormatter = dateFormatter,
        _messagePreviewResolver = previewDataResolver,
        _superGroupRepository = superGroupRepository,
        _avatarResolver = avatarResolver,
        _dateParser = dateParser;

  final ISuperGroupRepository _superGroupRepository;
  final IMessagePreviewResolver _messagePreviewResolver;
  final DateFormatter _dateFormatter;
  final DateParser _dateParser;
  final AvatarResolver _avatarResolver;

  Future<ChatTileModel> mapToModel({
    required td.Chat chat,
    required td.ChatList chatList,
  }) async {
    final MessagePreviewData preview =
        await _messagePreviewResolver.resolveFromChatOrEmpty(chat);

    final td.ChatPosition? position = chat.getPositionByChatList(chatList);
    assert(position != null);

    final bool isSecret =
        chat.type.getConstructor() == td.ChatTypeSecret.constructor;
    return ChatTileModel(
      isMuted: chat.notificationSettings.muteFor > 0,
      isVerified: await getVerified(chat),
      unreadMessagesCount: chat.unreadCount,
      isPinned: position!.isPinned,
      isRead: null,
      isSecret: isSecret,
      isMentioned: chat.unreadMentionCount > 0,
      lastMessageDate: _dateFormatter.formatChatLastMessageDateOrNull(
        _dateParser.parseUnixTimeStampToDateOrNull(chat.lastMessage?.date),
      ),
      id: chat.id,
      avatar: await _avatarResolver.resolveForChat(chat),
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
