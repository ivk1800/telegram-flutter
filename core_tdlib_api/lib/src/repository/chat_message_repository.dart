import 'package:tdlib/td_api.dart' as td;

abstract class IChatMessageRepository {
  Stream<List<td.Message>> getMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
  });

  Future<td.Message> getMessage({required int chatId, required int messageId});

  Future<List<td.Message>> findMessages({
    required String query,
    required int fromMessageId,
    required int fromChatId,
    required int limit,
    required td.SearchMessagesFilter filter,
  });

  Future<int> getMessagesCount({
    required int chatId,
    required td.SearchMessagesFilter filter,
  });
}
