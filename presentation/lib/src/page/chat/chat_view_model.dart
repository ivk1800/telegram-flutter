import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/presentation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatViewModel extends BaseViewModel {
  @j.inject
  ChatViewModel(this.chatId) {
    appComponent
        .getTdClient()
        .sendFunction<td.Messages>(td.GetChatHistory(
            chatId: chatId,
            fromMessageId: 0,
            offset: 0,
            limit: 10,
            onlyLocal: true))
        .listen((td.Messages event) {
      final List<td.Message>? messages = event.messages;
      if (messages != null) {
        _messagesSubject.add(messages);
      }
    });
  }

  final int chatId;

  final BehaviorSubject<List<td.Message>> _messagesSubject =
      BehaviorSubject<List<td.Message>>();

  Stream<List<td.Message>> get messages => _messagesSubject;

  @override
  void dispose() {
    _messagesSubject.close();
    super.dispose();
  }
}
