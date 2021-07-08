import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tuple/tuple.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

import 'chat_preview_data_resolver.dart';

class ChatTileModelMapper {
  @j.inject
  ChatTileModelMapper(
      {required DateFormatter dateFormatter,
      required DateParser dateParser,
      required ChatPreviewDataResolver previewDataResolver,
      required IChatRepository chatRepository})
      : _dateFormatter = dateFormatter,
        _previewDataResolver = previewDataResolver,
        _chatRepository = chatRepository,
        _dateParser = dateParser;

  final IChatRepository _chatRepository;
  final ChatPreviewDataResolver _previewDataResolver;
  final DateFormatter _dateFormatter;
  final DateParser _dateParser;

  Future<ChatTileModel> mapToModel(td.Chat chat) async {
    final ChatPreviewData preview = await _previewDataResolver.resolve(chat);

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
