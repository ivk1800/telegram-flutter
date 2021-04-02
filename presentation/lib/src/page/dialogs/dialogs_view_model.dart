import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/mapper/chat_tile_model_mapper.dart';
import 'package:presentation/src/model/model.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:tdlib/td_api.dart' as td;

class DialogsViewModel extends BaseViewModel {
  @j.inject
  DialogsViewModel(
      this._chatRepository, this._router, this._chatTileModelMapper);

  final IChatRepository _chatRepository;

  final INavigationRouter _router;

  final ChatTileModelMapper _chatTileModelMapper;

  Stream<List<ChatTileModel>> get chats => _chatRepository.chats.map(
      (event) => event.map((e) => _chatTileModelMapper.mapToModel(e)).toList());

  void onChatClick(int id) {
    _router.toChat(id);
  }
}
