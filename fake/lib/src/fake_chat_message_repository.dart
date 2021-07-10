import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeChatMessageRepository implements IChatMessageRepository {
  FakeChatMessageRepository({
    required this.fakeMessages,
  });

  final List<td.Message> fakeMessages;

  @override
  Stream<List<td.Message>> getMessages(
      {required int chatId, required int fromMessageId, required int limit}) {
    List<td.Message> messages = fakeMessages.take(limit).toList();

    messages += fakeMessages.take(limit - messages.length).toList();

    return Stream<List<td.Message>>.value(messages);
  }
}
