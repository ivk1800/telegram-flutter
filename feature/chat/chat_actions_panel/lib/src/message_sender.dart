import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

abstract class IMessageSender {
  Future<void> sendText({
    required int chatId,
    required String text,
  });
}

class MessageSender implements IMessageSender {
  MessageSender({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<void> sendText({required int chatId, required String text}) {
    return _functionExecutor.send<td.Message>(
      td.SendMessage(
        chatId: chatId,
        replyToMessageId: 0,
        messageThreadId: 0,
        inputMessageContent: td.InputMessageText(
          clearDraft: true,
          disableWebPagePreview: false,
          text: td.FormattedText(text: text, entities: const <td.TextEntity>[]),
        ),
      ),
    );
  }
}
