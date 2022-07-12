import 'dart:async';

import 'package:collection/collection.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_impl/src/mapper/chat_tile_model_mapper.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:queue/queue.dart' as q;
import 'package:td_api/td_api.dart' as td;

import 'chat_data.dart';
import 'chat_ext.dart';
import 'chat_list.dart';
import 'ordered_chat.dart';

class ChatListUpdateHandler {
  @j.inject
  ChatListUpdateHandler({
    required IChatRepository chatRepository,
    required ChatListConfig chatListConfig,
    required IChatsHolder chatsHolder,
    required ChatTileModelMapper chatTileModelMapper,
  })  : _chatTileModelMapper = chatTileModelMapper,
        _chatListConfig = chatListConfig,
        _chatsHolder = chatsHolder,
        _chatRepository = chatRepository;

  final ChatTileModelMapper _chatTileModelMapper;
  final IChatsHolder _chatsHolder;
  final IChatRepository _chatRepository;
  final ChatListConfig _chatListConfig;

  final q.Queue<bool> _eventsQueue = q.Queue<bool>();

  Set<OrderedChat> get _orderedChats => _chatsHolder.orderedChats;

  Map<int, ChatData> get _chats => _chatsHolder.chatsData;

  Future<bool> handleNewChat({required td.Chat chat}) =>
      _enqueue(() => _handleNewChat(chat: chat));

  Future<bool> handleNewPositions({
    required int chatId,
    required List<td.ChatPosition> positions,
  }) =>
      _enqueue(() => _handleNewPositions(chatId, positions));

  Future<bool> handleNewPosition(int chatId, td.ChatPosition position) =>
      _enqueue(() => _handleNewPosition(chatId, position));

  Future<bool> handleLastMessage(int chatId, td.Message? message) =>
      _enqueue(() => _handleLastMessage(chatId, message));

  Future<bool> handleUpdateChatReadInbox(td.UpdateChatReadInbox update) =>
      _enqueue(() => _handleUpdateChatReadInbox(update));

  Future<bool> handleUpdateChatUnreadMentionCount(
    td.UpdateChatUnreadMentionCount update,
  ) =>
      _enqueue(() => _handleUpdateChatUnreadMentionCount(update));

  Future<bool> handleUpdateMessageMentionRead(
    td.UpdateMessageMentionRead update,
  ) =>
      _enqueue(() => _handleUpdateMessageMentionRead(update));

  Future<bool> handleUpdateChatNotificationSettings(
    td.UpdateChatNotificationSettings update,
  ) =>
      _enqueue(() => _handleUpdateChatNotificationSettings(update));

  void dispose() {
    _eventsQueue.dispose();
  }

  Future<bool> _enqueue(Future<bool> Function() action) =>
      _eventsQueue.enqueue(action);

  Future<ChatData> _toChatData(td.Chat chat) async {
    return ChatData(
      chat: chat,
      model: await _chatTileModelMapper.mapToModel(
        chat: chat,
        chatList: _chatListConfig.chatList,
      ),
    );
  }

  ChatData? _getChatData(int chatId) => _chats[chatId];

  Future<bool> _handleNewChat({required td.Chat chat}) async {
    if (_chats.containsKey(chat.id)) {
      return false;
    }

    if (chat.positions.isEmpty) {
      return false;
    }

    final int? order = getOrder(chat);
    if (order == null) {
      return false;
    }

    final bool add = _orderedChats.add(
      OrderedChat(chatId: chat.id, order: order),
    );
    assert(add);

    final ChatData data = await _toChatData(chat);
    _chats[chat.id] = data;

    return true;
  }

  Future<bool> _handleNewPositions(
    int chatId,
    List<td.ChatPosition> positions,
  ) async {
    if (!_chats.containsKey(chatId)) {
      return false;
    }

    if (positions.isEmpty) {
      final ChatData? removeChat = _chats.remove(chatId);
      assert(removeChat != null);

      final int? order = getOrder(removeChat!.chat);
      assert(order != null);

      final bool removedPrevChat = _orderedChats.remove(
        OrderedChat(
          chatId: removeChat.chat.id,
          order: order!,
        ),
      );
      assert(removedPrevChat);

      return true;
    }

    final td.ChatPosition? position = positions.firstWhereOrNull(
      (td.ChatPosition position) =>
          position.list.getConstructor() ==
          _chatListConfig.chatList.getConstructor(),
    );

    if (position != null) {
      return _handleNewPosition(chatId, position);
    }
    return false;
  }

  Future<bool> _handleNewPosition(int chatId, td.ChatPosition position) async {
    if (position.list != _chatListConfig.chatList) {
      return false;
    }

    if (!_chats.containsKey(chatId)) {
      final bool handleNewChatResult =
          await _handleNewChat(chat: await _chatRepository.getChat(chatId));
      assert(handleNewChatResult);
    }

    final ChatData chatData = _chats[chatId]!;

    final int? order = getOrder(chatData.chat);
    assert(order != null);

    final bool removedPrevChat = _orderedChats.remove(
      OrderedChat(
        chatId: chatData.chat.id,
        order: order!,
      ),
    );
    assert(removedPrevChat);

    if (position.order == 0) {
      final ChatData? removeChat = _chats.remove(chatId);
      assert(removeChat != null);
    } else {
      final OrderedChat newOrderedChat =
          OrderedChat(chatId: chatData.chat.id, order: position.order);
      chatData
        ..chat = chatData.chat.copyWith(positions: <td.ChatPosition>[position])
        ..model = chatData.model.copy(
          isPinned: position.isPinned,
        );
      final bool add = _orderedChats.add(newOrderedChat);
      assert(add);
    }

    return true;
  }

  Future<bool> _handleLastMessage(int chatId, td.Message? message) async {
    if (!_chats.containsKey(chatId)) {
      return false;
    }
    final ChatData chatData = _chats[chatId]!;
    chatData
      ..chat = chatData.chat.copyWith(lastMessage: message)
      // ignore: flutter_style_todos
      //TODO(Ivan): map only changed part
      ..model = await _chatTileModelMapper.mapToModel(
        chat: chatData.chat,
        chatList: _chatListConfig.chatList,
      );
    return true;
  }

  Future<bool> _handleUpdateChatReadInbox(td.UpdateChatReadInbox update) async {
    final ChatData? chatData = _getChatData(update.chatId);

    if (chatData == null) {
      return false;
    }

    chatData
      ..chat = chatData.chat.copyWith(
        unreadCount: update.unreadCount,
        // all messages was read, set 0 to MentionCount
        // because Update for it not incoming
        unreadMentionCount:
            update.unreadCount == 0 ? 0 : chatData.chat.unreadMentionCount,
        lastReadInboxMessageId: update.lastReadInboxMessageId,
      )
      ..model = await _chatTileModelMapper.mapToModel(
        chat: chatData.chat,
        chatList: _chatListConfig.chatList,
      );
    return true;
  }

  Future<bool> _handleUpdateChatUnreadMentionCount(
    td.UpdateChatUnreadMentionCount update,
  ) async {
    final ChatData? chatData = _getChatData(update.chatId);

    if (chatData == null) {
      return false;
    }

    chatData
      ..chat =
          chatData.chat.copyWith(unreadMentionCount: update.unreadMentionCount)
      ..model = await _chatTileModelMapper.mapToModel(
        chat: chatData.chat,
        chatList: _chatListConfig.chatList,
      );
    return true;
  }

  Future<bool> _handleUpdateMessageMentionRead(
    td.UpdateMessageMentionRead update,
  ) async {
    final ChatData? chatData = _getChatData(update.chatId);

    if (chatData == null) {
      return false;
    }

    chatData
      ..chat = chatData.chat.copyWith(
        unreadMentionCount: update.unreadMentionCount,
      )
      ..model = await _chatTileModelMapper.mapToModel(
        chat: chatData.chat,
        chatList: _chatListConfig.chatList,
      );
    return true;
  }

  Future<bool> _handleUpdateChatNotificationSettings(
    td.UpdateChatNotificationSettings update,
  ) async {
    final ChatData? chatData = _getChatData(update.chatId);

    if (chatData == null) {
      return false;
    }

    chatData
      ..chat = chatData.chat.copyWith(
        notificationSettings: update.notificationSettings,
      )
      ..model = await _chatTileModelMapper.mapToModel(
        chat: chatData.chat,
        chatList: _chatListConfig.chatList,
      );
    return true;
  }

  int? getOrder(td.Chat chat) =>
      chat.getPositionByChatList(_chatListConfig.chatList)?.order;
}
