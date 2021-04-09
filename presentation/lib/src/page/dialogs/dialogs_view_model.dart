import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/model/model.dart';
import 'package:presentation/src/navigation/navigation.dart';

import 'chat_list_interactor.dart';

class DialogsViewModel extends BaseViewModel {
  @j.inject
  DialogsViewModel(this._router, this._interactor) {
    _interactor.load();
  }

  final INavigationRouter _router;

  final ChatListInteractor _interactor;

  Stream<List<ChatTileModel>> get chats => _interactor.chats;

  void onChatClick(int id) {
    _router.toChat(id);
  }
}
