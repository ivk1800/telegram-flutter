import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatMessageRepositoryImpl implements IChatMessageRepository {
  ChatMessageRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Stream<List<td.Message>> getMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
  }) {
    return _getMessages(
      chatId: chatId,
      fromMessageId: fromMessageId,
      limit: limit,
    ).flatMap((List<td.Message> messages) {
      if (messages.isNotEmpty && messages.length != limit) {
        return getMessages(
          chatId: chatId,
          fromMessageId: messages.last.id,
          limit: limit,
        ).map((List<td.Message> additionalMessages) =>
            messages..addAll(additionalMessages));
      }

      return Stream<List<td.Message>>.value(messages);
    });
  }

  @override
  Future<td.Message> getMessage({required int chatId, required int messageId}) {
    return _functionExecutor.send<td.Message>(td.GetMessage(
      chatId: chatId,
      messageId: messageId,
    ));
  }

  Stream<List<td.Message>> _getMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
  }) =>
      Stream<td.Messages>.fromFuture(_functionExecutor.send<td.Messages>(
        td.GetChatHistory(
          chatId: chatId,
          fromMessageId: fromMessageId,
          offset: 0,
          limit: limit,
          onlyLocal: false,
        ),
      )).map((td.Messages event) => event.messages ?? <td.Message>[]);

  @override
  Future<List<td.Message>> findMessages({
    required int chatId,
    required int fromMessageId,
    required int limit,
    required td.SearchMessagesFilter filter,
  }) {
    return _get<td.Message>(
      (td.Message? last) async {
        return _functionExecutor
            .send<td.Messages>(
              td.SearchChatMessages(
                chatId: chatId,
                filter: filter,
                fromMessageId: last?.id ?? fromMessageId,
                limit: limit,
                messageThreadId: 0,
                offset: 0,
                query: '',
              ),
            )
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
