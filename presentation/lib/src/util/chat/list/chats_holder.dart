import 'chat_data.dart';
import 'ordered_chat.dart';

abstract class IChatsHolder {
  Set<OrderedChat> get orderedChats;

  Map<int, ChatData> get chatsData;
}
