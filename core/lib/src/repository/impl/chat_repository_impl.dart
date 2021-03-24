import 'package:core/core.dart';
import 'package:core/src/repository/chat_repository.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatRepositoryImpl extends IChatRepository {
  @j.inject
  ChatRepositoryImpl(this._client) {
    _client.clientSend(td.GetChats(
      offsetChatId: 0,
      offsetOrder: 1000,
      chatList: const td.ChatListMain(),
      limit: 10,
    ));
    _client.events
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
    _client.events
        .where((td.TdObject event) => event is td.UpdateFile)
        .map((td.TdObject event) => event as td.UpdateFile)
        .listen((td.UpdateFile event) {
      final td.Chat? associatedChat =
          _chats.values.firstWhereOrNull((td.Chat chat) {
        final td.ChatPhotoInfo? photoInfo = chat.photo;
        return photoInfo != null &&
            (photoInfo.small.id == event.file.id ||
                photoInfo.big.id == event.file.id);
      });

      if (associatedChat != null) {
        _chats[associatedChat.id] = associatedChat.copy(
            photo: associatedChat.photo?.copy(
                big: associatedChat.photo?.big.id == event.file.id
                    ? event.file
                    : associatedChat.photo?.big,
                small: associatedChat.photo?.small.id == event.file.id
                    ? event.file
                    : associatedChat.photo?.small));
        _chatsSubject.add(_chats.values.toList());
      }
    });
  }

  final TdClient _client;

  final Map<int, td.Chat> _chats = <int, td.Chat>{};

  final BehaviorSubject<List<td.Chat>> _chatsSubject =
      BehaviorSubject<List<td.Chat>>();

  @override
  Stream<List<td.Chat>> get chats => _chatsSubject;
}
