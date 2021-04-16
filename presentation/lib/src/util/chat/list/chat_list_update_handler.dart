import 'package:core/core.dart';
import 'package:presentation/src/mapper/mapper.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_client.dart';
import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:presentation/src/model/model.dart';
import 'chat_data.dart';
import 'chat_list.dart';
import 'chat_list_config.dart';
import 'ordered_chat.dart';

class ChatListUpdateHandler {
  @j.inject
  ChatListUpdateHandler(
      {required IChatRepository chatRepository,
      required ChatListConfig chatListConfig,
      required IChatsHolder chatsHolder,
      required ChatTileModelMapper chatTileModelMapper})
      : _chatTileModelMapper = chatTileModelMapper,
        _chatListConfig = chatListConfig,
        _chatsHolder = chatsHolder,
        _chatRepository = chatRepository;

  final ChatTileModelMapper _chatTileModelMapper;
  final IChatsHolder _chatsHolder;
  final IChatRepository _chatRepository;
  final ChatListConfig _chatListConfig;

  Set<OrderedChat> get _orderedChats => _chatsHolder.orderedChats;

  Map<int, ChatData> get _chats => _chatsHolder.chatsData;

  void handleNewChat({required td.Chat chat}) {
    if (chat.positions.isEmpty) {
      return;
    }
    assert(chat.positions.length == 1);

    final int order = chat.getPosition().order;
    _orderedChats.add(OrderedChat(chatId: chat.id, order: order));

    final ChatData data = _toChatData(chat);
    assert(data.chat.positions.length == 1);
    _chats[chat.id] = data;
  }

  ChatData _toChatData(td.Chat chat) {
    return ChatData(chat: chat, model: _chatTileModelMapper.mapToModel(chat));
  }

  bool handleNewPositions(int chatId, List<td.ChatPosition> positions) {
    final td.ChatPosition? position = positions.firstWhereOrNull(
        (td.ChatPosition position) =>
            position.list.getConstructor() ==
            _chatListConfig.chatList.getConstructor());

    if (position != null) {
      return handleNewPosition(chatId, position);
    }
    return false;
  }

  bool handleNewPosition(int chatId, td.ChatPosition position) {
    if (!_chats.containsKey(chatId)) {
      return false;
    }

    final ChatData chatData = _chats[chatId]!;
    assert(chatData.chat.positions.length == 1);
    final bool remove = _orderedChats.remove(OrderedChat(
        chatId: chatData.chat.id, order: chatData.chat.getPosition().order));
    assert(remove);
    chatData.chat = chatData.chat.copy(positions: <td.ChatPosition>[position]);
    chatData.model = chatData.model.copy(isPinned: position.isPinned);

    _orderedChats
        .add(OrderedChat(chatId: chatData.chat.id, order: position.order));

    return true;
  }

  bool handleLastMessage(int chatId, td.Message? message) {
    if (!_chats.containsKey(chatId)) {
      return false;
    }
    final ChatData chatData = _chats[chatId]!;
    chatData.chat = chatData.chat.copy(lastMessage: message);
    // ignore: flutter_style_todos
    //TODO(Ivan): map only changed part
    chatData.model = _chatTileModelMapper.mapToModel(chatData.chat);
    return true;
  }

  bool handleUpdateChatReadInbox(td.UpdateChatReadInbox update) {
    final ChatData? chatData = _getChatData(update.chatId);

    if (chatData == null) {
      return false;
    }

    chatData.chat = chatData.chat.copy(
        unreadCount: update.unreadCount,
        lastReadInboxMessageId: update.lastReadInboxMessageId);

    chatData.model = _chatTileModelMapper.mapToModel(chatData.chat);
    return true;
  }

  ChatData? _getChatData(int chatId) => _chats[chatId];
}

extension _ChatExtensions on td.Chat {
  td.ChatPosition getPosition() {
    assert(positions.length == 1);
    return positions[0];
  }
}
