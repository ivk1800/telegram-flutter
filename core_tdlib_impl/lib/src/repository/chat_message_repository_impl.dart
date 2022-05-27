import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatMessageRepositoryImpl implements IChatMessageRepository {
  ChatMessageRepositoryImpl({
    required ChatMessageDataSource dataSource,
  }) : _dataSource = dataSource;

  final ChatMessageDataSource _dataSource;

  @override
  Future<List<td.Message>> getMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
  }) =>
      _dataSource.getMessages(
        chatId: chatId,
        fromMessageId: fromMessageId,
        limit: limit,
      );

  @override
  Future<td.Message?> getMessage({
    required int chatId,
    required int messageId,
  }) =>
      _dataSource.getMessage(
        chatId: chatId,
        messageId: messageId,
      );

  @override
  Future<List<td.Message>> findMessages({
    required String query,
    required int fromMessageId,
    required int fromChatId,
    required int limit,
    required td.SearchMessagesFilter filter,
  }) =>
      _dataSource.findMessages(
        query: query,
        fromMessageId: fromMessageId,
        fromChatId: fromChatId,
        limit: limit,
        filter: filter,
      );

  @override
  Future<int> getMessagesCount({
    required int chatId,
    required td.SearchMessagesFilter filter,
  }) =>
      _dataSource.getMessagesCount(
        chatId: chatId,
        filter: filter,
      );
}
