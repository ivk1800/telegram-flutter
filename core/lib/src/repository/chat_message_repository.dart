import 'package:tdlib/td_api.dart' as td;

abstract class IChatMessageRepository {
  Stream<List<td.Message>> getMessages(
      {required int chatId, required int fromMessageId, required int limit});
}
