import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeChatMessageRepository implements IChatMessageRepository {
  FakeChatMessageRepository({
    required this.fakeMessages,
  });

  final List<td.Message> fakeMessages;

  @override
  Future<List<td.Message>> getMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
  }) async {
    List<td.Message> messages = fakeMessages.take(limit).toList();

    messages += fakeMessages.take(limit - messages.length).toList();

    return messages;
  }

  @override
  Future<td.Message?> getMessage({
    required int chatId,
    required int messageId,
  }) async {
    return fakeMessages.first;
  }

  @override
  Future<List<td.Message>> findMessages({
    required String query,
    required int fromMessageId,
    required int fromChatId,
    required int limit,
    required td.SearchMessagesFilter filter,
  }) {
    return Completer<List<td.Message>>().future;
  }

  @override
  Future<int> getMessagesCount({
    required int chatId,
    required td.SearchMessagesFilter filter,
  }) async {
    return 1;
  }
}
