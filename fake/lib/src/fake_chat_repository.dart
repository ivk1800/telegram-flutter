import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeChatRepository implements IChatRepository {
  @override
  // TODO: implement chats
  Stream<List<td.Chat>> get chats => throw UnimplementedError();

  @override
  Future<td.Chat> getChat(int id) {
    // TODO: implement getChat
    throw UnimplementedError();
  }

  @override
  Future<List<td.Chat>> getChats(
      {required int offsetChatId,
      required int offsetOrder,
      required int limit,
      required td.ChatList chatList}) {
    // TODO: implement getChats
    throw UnimplementedError();
  }

  @override
  Future<td.Supergroup> getSupergroup(int id) {
    // TODO: implement getSupergroup
    throw UnimplementedError();
  }
}
