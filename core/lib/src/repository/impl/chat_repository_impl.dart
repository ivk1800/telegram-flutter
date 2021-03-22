import 'package:core/src/repository/chat_repository.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/src/tdapi/tdapi.dart' as td;

class ChatRepositoryImpl extends IChatRepository {
  @j.inject
  ChatRepositoryImpl(this.client) {
    client.clientSend(td.GetChats(
      offsetChatId: 0,
      offsetOrder: 1000,
      chatList: const td.ChatListMain(),
      limit: 10,
    ));
    client.events
        .where((td.TdObject event) =>
            event is td.UpdateNewChat || event is td.UpdateChatLastMessage)
        .listen((td.TdObject event) {
      if (event is td.UpdateNewChat) {
        _chats[event.chat.id] = event.chat;
        _chatsSubject.add(_chats.values.toList());
      } else if (event is td.UpdateChatLastMessage) {
        _chats[event.chatId] =
            _chats[event.chatId]!.copy(lastMessage: event.lastMessage);
      }
    });
  }

  final TdClient client;

  final Map<int, td.Chat> _chats = <int, td.Chat>{};

  final BehaviorSubject<List<td.Chat>> _chatsSubject =
      BehaviorSubject<List<td.Chat>>();

  @override
  Stream<List<td.Chat>> get chats => _chatsSubject;
}
