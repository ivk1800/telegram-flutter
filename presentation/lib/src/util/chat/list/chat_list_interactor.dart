import 'dart:async';
import 'package:core/core.dart';
import 'package:presentation/src/model/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;
import 'package:dart_numerics/dart_numerics.dart' as numerics;

import 'chat_list.dart';
import 'chat_list_update_handler.dart';
import 'ordered_chat.dart';

class ChatListInteractor {
  @j.inject
  ChatListInteractor(
      {required IChatRepository chatRepository,
      required IChatUpdatesProvider chatUpdatesProvider,
      required IChatsHolder chatsHolder,
      required ChatListConfig chatListConfig,
      required ChatListUpdateHandler chatListUpdateHandler})
      : _chatRepository = chatRepository,
        _chatsHolder = chatsHolder,
        _chatListConfig = chatListConfig,
        _chatListUpdateHandler = chatListUpdateHandler,
        _chatUpdatesProvider = chatUpdatesProvider;

  final ChatListUpdateHandler _chatListUpdateHandler;

  final IChatUpdatesProvider _chatUpdatesProvider;

  final IChatRepository _chatRepository;

  final IChatsHolder _chatsHolder;

  final ChatListConfig _chatListConfig;

  StreamSubscription<td.Update>? _chatUpdatesSubscription;

  final BehaviorSubject<List<ChatTileModel>> _chatsSubject =
      BehaviorSubject<List<ChatTileModel>>();

  Stream<List<ChatTileModel>> get chats => _chatsSubject;

  td.Chat getChat(int id) => _chatsHolder.chatsData[id]!.chat;

  void dispose() {
    _chatUpdatesSubscription?.cancel();
  }

  void load() {
    Stream<List<td.Chat>>.fromFuture(_chatRepository.getChats(
            offsetChatId: 0,
            offsetOrder: numerics.int64MaxValue,
            chatList: _chatListConfig.chatList,
            limit: 30))
        .listen((List<td.Chat> newChats) {
      for (final td.Chat chat in newChats) {
        _chatListUpdateHandler.handleNewChat(chat: chat);
      }
      _dispatchChats();

      _chatUpdatesSubscription =
          _chatUpdatesProvider.chatUpdates.listen(_handleChatUpdate);
    });
  }

  void _dispatchChats() {
    _chatsSubject.add(_chatsHolder.orderedChats
        .map((OrderedChat element) =>
            _chatsHolder.chatsData[element.chatId]!.model)
        .toList());
  }

  void _handleChatUpdate(td.Update event) {
    if (event is td.UpdateChatPosition) {
      if (_chatListUpdateHandler.handleNewPosition(
          event.chatId, event.position)) {
        _dispatchChats();
      }
    } else if (event is td.UpdateChatLastMessage) {
      final bool handleLastMessage = _chatListUpdateHandler.handleLastMessage(
          event.chatId, event.lastMessage);
      final bool handleNewPositions = _chatListUpdateHandler.handleNewPositions(
          event.chatId, event.positions);
      if (handleLastMessage || handleNewPositions) {
        _dispatchChats();
      }
    } else if (event is td.UpdateChatReadInbox) {
      if (_chatListUpdateHandler.handleUpdateChatReadInbox(event)) {
        _dispatchChats();
      }
    }
  }
}
