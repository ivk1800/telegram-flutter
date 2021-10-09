import 'dart:async';

import 'package:collection/collection.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_state.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:feature_chats_list_impl/src/util/loader.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

import 'chat_list.dart';
import 'chat_list_update_handler.dart';
import 'ordered_chat.dart';

class ChatListInteractor {
  @j.inject
  ChatListInteractor({
    required IChatRepository chatRepository,
    required IChatUpdatesProvider chatUpdatesProvider,
    required IChatsHolder chatsHolder,
    required ChatListConfig chatListConfig,
    required ChatListUpdateHandler chatListUpdateHandler,
  })  : _chatRepository = chatRepository,
        _chatsHolder = chatsHolder,
        _chatListConfig = chatListConfig,
        _chatListUpdateHandler = chatListUpdateHandler,
        _chatUpdatesProvider = chatUpdatesProvider {
    _loader = Loader<td.Chat>(
      builder: () {
        final OrderedChat? lastChat = _chatsHolder.orderedChats.lastOrNull;
        return Stream<List<td.Chat>>.fromFuture(_chatRepository.getChats(
          offsetChatId: lastChat?.chatId ?? 0,
          offsetOrder: lastChat?.order ?? 9223372036854775807,
          chatList: _chatListConfig.chatList,
          limit: 30,
        ));
      },
      onResult: (List<td.Chat> newChats) async {
        _done = true;
        for (final td.Chat chat in newChats) {
          await _chatListUpdateHandler.handleNewChat(chat: chat);
        }
        _dispatchChats();
        _chatUpdatesSubscription ??=
            _chatUpdatesProvider.chatUpdates.listen(_handleChatUpdate);
      },
      onError: (Object? error) {},
    );
  }

  late bool _done = false;

  late Loader<td.Chat> _loader;

  final ChatListUpdateHandler _chatListUpdateHandler;

  final IChatUpdatesProvider _chatUpdatesProvider;

  final IChatRepository _chatRepository;

  final IChatsHolder _chatsHolder;

  final ChatListConfig _chatListConfig;

  StreamSubscription<td.Update>? _chatUpdatesSubscription;

  final BehaviorSubject<ChatsListState> _chatsSubject =
      BehaviorSubject<ChatsListState>.seeded(const ChatsListState.loading());

  Stream<ChatsListState> get chats => _chatsSubject;

  td.Chat getChat(int id) => _chatsHolder.chatsData[id]!.chat;

  void dispose() {
    _loader.dispose();
    _chatListUpdateHandler.dispose();
    _chatUpdatesSubscription?.cancel();
  }

  void load() {
    if (_done) {
      return;
    }
    _loader.load();
  }

  void _dispatchChats() {
    //todo need optimizing, new list created on each dispatch
    final List<ChatTileModel> list = _chatsHolder.orderedChats
        .map((OrderedChat element) =>
            _chatsHolder.chatsData[element.chatId]!.model)
        .toList();
    _chatsSubject.add(ChatsListState.data(list));
  }

  Future<void> _handleChatUpdate(td.Update event) async {
    if (event is td.UpdateChatPosition) {
      if (await _chatListUpdateHandler.handleNewPosition(
        event.chatId,
        event.position,
      )) {
        _dispatchChats();
      }
    } else if (event is td.UpdateChatLastMessage) {
      final bool handleLastMessage = await _chatListUpdateHandler
          .handleLastMessage(event.chatId, event.lastMessage);
      final bool handleNewPositions = await _chatListUpdateHandler
          .handleNewPositions(event.chatId, event.positions);
      if (handleLastMessage || handleNewPositions) {
        _dispatchChats();
      }
    } else if (event is td.UpdateChatReadInbox) {
      if (await _chatListUpdateHandler.handleUpdateChatReadInbox(event)) {
        _dispatchChats();
      }
    } else if (event is td.UpdateChatNotificationSettings) {
      if (await _chatListUpdateHandler
          .handleUpdateChatNotificationSettings(event)) {
        _dispatchChats();
      }
    } else if (event is td.UpdateNewChat) {
      /// chat without positions(is empty)
      /// fetch actual chat from repo
      if (await _chatListUpdateHandler.handleNewChat(
        chat: await _chatRepository.getChat(event.chat.id),
      )) {
        _dispatchChats();
      }
    } else if (event is td.UpdateChatUnreadMentionCount) {
      if (await _chatListUpdateHandler
          .handleUpdateChatUnreadMentionCount(event)) {
        _dispatchChats();
      }
    } else if (event is td.UpdateMessageMentionRead) {
      if (await _chatListUpdateHandler.handleUpdateMessageMentionRead(event)) {
        _dispatchChats();
      }
    }
  }
}
