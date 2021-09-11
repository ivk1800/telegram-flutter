import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatManagerImpl implements IChatManager {
  ChatManagerImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<void> leave(int chatId) =>
      _functionExecutor.send(td.LeaveChat(chatId: chatId));
}
