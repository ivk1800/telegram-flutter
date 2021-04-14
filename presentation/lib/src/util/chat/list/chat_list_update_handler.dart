import 'package:presentation/src/mapper/mapper.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_client.dart';
import 'package:presentation/src/model/model.dart';
import 'chat_data.dart';
import 'ordered_chat.dart';

abstract class IChatsHolder {
  Set<OrderedChat> get orderedChats;

  Map<int, ChatData> get chatsData;
}

class ChatListUpdateHandler {
  @j.inject
  ChatListUpdateHandler(this._chatTileModelMapper);

  final ChatTileModelMapper _chatTileModelMapper;

  late IChatsHolder _holder;

  void bind(IChatsHolder holder) {
    _holder = holder;
  }

  Set<OrderedChat> get _orderedChats => _holder.orderedChats;

  Map<int, ChatData> get _chats => _holder.chatsData;

  void handleNewChat({required td.Chat chat}) {
    if (chat.positions.isEmpty) {
      _chats[chat.id] = _toChatData(chat);
      return;
    }
    assert(chat.positions.length == 1);

    final int order = chat.positions[0].order;
    _orderedChats.add(OrderedChat(chatId: chat.id, order: order));

    final ChatData data = _toChatData(chat);
    assert(data.chat.positions.length == 1);
    _chats[chat.id] = data;
  }

  ChatData _toChatData(td.Chat chat) {
    return ChatData(chat: chat, model: _chatTileModelMapper.mapToModel(chat));
  }

  void handleNewPosition(int chatId, td.ChatPosition position) {
    final ChatData chatData = _chats[chatId]!;
    assert(chatData.chat.positions.length == 1);
    assert(_orderedChats.remove(OrderedChat(
        chatId: chatData.chat.id, order: chatData.chat.positions[0].order)));

    chatData.chat = chatData.chat.copy(positions: <td.ChatPosition>[position]);
    chatData.model = chatData.model.copy(isPinned: position.isPinned);

    _orderedChats
        .add(OrderedChat(chatId: chatData.chat.id, order: position.order));
  }

  void handleLastMessage(int chatId, td.Message? message) {
    final ChatData chatData = _chats[chatId]!;
    chatData.chat = chatData.chat.copy(lastMessage: message);
    // ignore: flutter_style_todos
    //TODO(Ivan): map only changed part
    chatData.model = _chatTileModelMapper.mapToModel(chatData.chat);
  }
}
