import 'package:tdlib/td_api.dart' as td;

abstract class IChatRepository {
  Stream<List<td.Chat>> get chats;
}
