import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_impl/src/chat_screen_router.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tdlib/td_api.dart' as td;

import 'chat_args.dart';

class ChatViewModel extends BaseViewModel {
  @j.inject
  ChatViewModel(
      {required ChatArgs args,
      required IChatScreenRouter router,
      required ChatMessagesInteractor messagesInteractor})
      : _args = args,
        _router = router,
        _messagesInteractor = messagesInteractor {
    _messagesInteractor.init(_args.chatId);
  }

  final ChatArgs _args;
  final ChatMessagesInteractor _messagesInteractor;
  final IChatScreenRouter _router;

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
