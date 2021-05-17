import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/presentation.dart';
import 'package:presentation/src/util/chat/list/chat_list.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:presentation/src/model/model.dart';
import 'package:presentation/src/navigation/navigation.dart';

class DialogsViewModel extends BaseViewModel {
  @j.inject
  DialogsViewModel(this._router, this._interactor) {
    _interactor.load();
  }

  final INavigationRouter _router;

  final ChatListInteractor _interactor;

  Stream<List<ChatTileModel>> get chats => _interactor.chats;

  void onChatTap(int id) {
    _router.toChat(id);
  }

  void onChatPinToggleTap(int id) {
    final td.Chat chat = _interactor.getChat(id);

    appComponent.getTdClient().send<td.Ok>(td.ToggleChatIsPinned(
        chatList: const td.ChatListMain(),
        chatId: chat.id,
        isPinned: !chat.positions[0].isPinned));
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
