import 'package:tdlib/td_api.dart' as td;

abstract class IChatRepository {
  Future<td.Chat> getChat(int id);

  Future<td.Supergroup> getSupergroup(int id);

  Future<List<td.Chat>> getChats({
    required int offsetChatId,
    required int offsetOrder,
    required int limit,
    required td.ChatList chatList,
  });
}
