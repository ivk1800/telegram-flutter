import 'package:core/core.dart';
import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

class ChatViewModel extends BaseViewModel {
  @j.inject
  ChatViewModel(this._chatId, this._messagesInteractor) {
    _messagesInteractor.init(_chatId);
  }

  final int _chatId;
  final ChatMessagesInteractor _messagesInteractor;

  Stream<List<td.Message>> get messages => _messagesInteractor.messages;

  void onScroll() {
    _messagesInteractor.loadMore();
  }

  @override
  void dispose() {
    _messagesInteractor.dispose();
    super.dispose();
  }
}
