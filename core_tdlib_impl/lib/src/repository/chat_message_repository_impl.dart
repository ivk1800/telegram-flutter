import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatMessageRepositoryImpl implements IChatMessageRepository {
  ChatMessageRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<List<td.Message>> getMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
  }) async {
    final List<td.Message> messages = await _getMessages(
      chatId: chatId,
      fromMessageId: fromMessageId,
      limit: limit,
    );
    if (messages.isNotEmpty && messages.length != limit) {
      final List<td.Message> additionalMessages = await getMessages(
        chatId: chatId,
        fromMessageId: messages.last.id,
        limit: limit,
      );
      return messages..addAll(additionalMessages);
    }

    return messages;
  }

  @override
  Future<td.Message?> getMessage({
    required int chatId,
    required int messageId,
  }) {
    return _functionExecutor
        .send<td.Message>(td.GetMessage(
          chatId: chatId,
          messageId: messageId,
        ))
        .then((td.Message value) => Future<td.Message?>.value(value))
        .catchError(
          // todo log error
          (Object? error) => null,
          // todo handle only 404 error
          test: (Object error) => error is TdError,
        );
  }

  Future<List<td.Message>> _getMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
  }) async {
    final td.Messages messages = await _functionExecutor.send<td.Messages>(
      td.GetChatHistory(
        chatId: chatId,
        fromMessageId: fromMessageId,
        offset: 0,
        limit: limit,
        onlyLocal: false,
      ),
    );
    return messages.messages ?? <td.Message>[];
  }

  @override
  Future<List<td.Message>> findMessages({
    required String query,
    required int fromMessageId,
    required int fromChatId,
    required int limit,
    required td.SearchMessagesFilter filter,
  }) {
    return _get<td.Message>(
      (td.Message? last) async {
        return _functionExecutor
            .send<td.Messages>(td.SearchMessages(
              minDate: 0,
              maxDate: 0,
              offsetChatId: last?.chatId ?? fromChatId,
              offsetDate: 0,
              offsetMessageId: last?.id ?? fromMessageId,
              filter: filter,
              limit: limit,
              query: query,
            ))
            .then((td.Messages value) => value.messages ?? <td.Message>[]);
      },
      limit,
    );
  }

  Future<List<T>> _get<T>(
    Future<List<T>> Function(T? last) fetcher,
    int limit,
  ) async {
    final List<T> messages = await fetcher.call(null);

    if (messages.isNotEmpty && messages.length != limit) {
      final List<T> additionalMessages = await fetcher.call(messages.last);
      messages.addAll(additionalMessages);
    }

    return messages;
  }

  @override
  Future<int> getMessagesCount({
    required int chatId,
    required td.SearchMessagesFilter filter,
  }) =>
      _functionExecutor
          .send<td.Count>(td.GetChatMessageCount(
            chatId: chatId,
            filter: filter,
            returnLocal: false,
          ))
          .then((td.Count value) => value.count);
}
