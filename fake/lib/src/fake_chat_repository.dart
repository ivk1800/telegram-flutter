import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

import 'fakes.dart';

class FakeChatRepository implements IChatRepository {
  @override
  Future<td.Chat> getChat(int id) async {
    return createFakeChat();
  }

  @override
  Future<List<td.Chat>> getChats({
    required int offsetChatId,
    required int offsetOrder,
    required int limit,
    required td.ChatList chatList,
  }) async {
    return <td.Chat>[createFakeChat()];
  }

  @override
  Future<List<td.Chat>> findChats({required String query}) {
    return Completer<List<td.Chat>>().future;
  }
}
