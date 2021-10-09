import 'package:core_arch/core_arch.dart';
import 'package:feature_chats_list_impl/src/chats_list_screen_router.dart';
import 'package:feature_chats_list_impl/src/list/chat_list.dart';
import 'package:tdlib/td_api.dart' as td;

import 'chats_list_state.dart';

class ChatsListViewModel extends BaseViewModel {
  ChatsListViewModel({
    required IChatsListScreenRouter router,
    required ChatListInteractor interactor,
  })  : _router = router,
        _interactor = interactor {
    _interactor.load();
  }

  final IChatsListScreenRouter _router;

  final ChatListInteractor _interactor;

  Stream<ChatsListState> get chatsListState => _interactor.chats;

  void onChatTap(int id) {
    _router.toChat(id);
  }

  void onChatPinToggleTap(int id) {
    final td.Chat chat = _interactor.getChat(id);

    // appComponent.getTdClient().send<td.Ok>(td.ToggleChatIsPinned(
    //     chatList: const td.ChatListMain(),
    //     chatId: chat.id,
    //     isPinned: !chat.positions[0].isPinned));
  }

  void onScroll() {
    _interactor.load();
  }

  @override
  void dispose() {
    _interactor.dispose();
    super.dispose();
  }
}
