import 'package:core_arch/core_arch.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat_screen_router.dart';

class NewChatViewModel extends BaseViewModel {
  NewChatViewModel({
    required INewChatScreenRouter router,
  }) : _router = router;

  final INewChatScreenRouter _router;

  void onNewGroupTap() => _router.toCreateNewGroup();

  void onNewSecretChatTap() => _router.toCreateNewSecretChat();

  void onNewChannelTap() => _router.toCreateNewChannel();
}
