import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeChatRepository implements IChatRepository {
  @override
  Future<td.Chat> getChat(int id) {
    return Completer<td.Chat>().future;
  }

  @override
  Future<List<td.Chat>> getChats({
    required int offsetChatId,
    required int offsetOrder,
    required int limit,
    required td.ChatList chatList,
  }) {
    return Completer<List<td.Chat>>().future;
  }

  @override
  Future<td.Supergroup> getSupergroup(int id) {
    return Completer<td.Supergroup>().future;
  }

  @override
  Future<List<td.Chat>> findChats({required String query}) {
    return Completer<List<td.Chat>>().future;
  }
}
