import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/navigation/navigation.dart';
import 'package:tdlib/td_api.dart' as td;

class DialogsViewModel extends BaseViewModel {
  @j.inject
  DialogsViewModel(this.chatRepository, this.router);

  final IChatRepository chatRepository;

  final INavigationRouter router;

  Stream<List<td.Chat>> get chats => chatRepository.chats;

  void onChatClick(td.Chat chat) {
    router.toChat(chat.id);
  }
}
