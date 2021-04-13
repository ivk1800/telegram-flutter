import 'dart:collection';

import 'package:core/core.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/mapper/mapper.dart';
import 'package:presentation/src/model/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;
import 'package:dart_numerics/dart_numerics.dart' as numerics;

import 'chat_list_update_handler.dart';
import 'chat_data.dart';
import 'ordered_chat.dart';

class ChatListInteractor implements IChatsHolder {
  @j.inject
  ChatListInteractor(this._chatRepository, this._chatListUpdateHandler) {
    _chatListUpdateHandler.bind(this);
  }

  final ChatListUpdateHandler _chatListUpdateHandler;

  final IChatRepository _chatRepository;

  final SplayTreeSet<OrderedChat> _orderedChats = SplayTreeSet<OrderedChat>();
  final Map<int, ChatData> _chats = <int, ChatData>{};

  final BehaviorSubject<List<ChatTileModel>> _chatsSubject =
      BehaviorSubject<List<ChatTileModel>>();

  Stream<List<ChatTileModel>> get chats => _chatsSubject;

  @override
  Set<OrderedChat> get orderedChats => _orderedChats;

  @override
  Map<int, ChatData> get chatsData => _chats;

  td.Chat getChat(int id) {
    return _chats[id]!.chat;
  }

  void load() {
    Stream<List<td.Chat>>.fromFuture(_chatRepository.getChats(
            offsetChatId: 0,
            offsetOrder: numerics.int64MaxValue,
            chatList: const td.ChatListMain(),
            limit: 30))
        .listen((List<td.Chat> newChats) {
      for (final td.Chat chat in newChats) {
        _chatListUpdateHandler.handleNewChat(chat: chat);
      }
      _dispatchChats();

      appComponent.getTdClient().events.listen((td.TdObject event) {
        if (event is td.UpdateChatPosition) {
          if (_chats.containsKey(event.chatId)) {
            _chatListUpdateHandler.handleNewPosition(
                event.chatId, event.position);
            _dispatchChats();
          }
        } else if (event is td.UpdateChatLastMessage) {
          if (_chats.containsKey(event.chatId)) {
            _chatListUpdateHandler.handleLastMessage(
                event.chatId, event.lastMessage);
            _chatListUpdateHandler.handleNewPosition(
                event.chatId, event.positions.first);
            _dispatchChats();
          }
        }
      });
    });
  }

  void _dispatchChats() {
    _chatsSubject.add(_orderedChats
        .map((OrderedChat element) => _chats[element.chatId]!.model)
        .toList());
  }
}
