import 'package:core_arch/core_arch.dart';
import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat_screen_router.dart';
import 'package:jugger/jugger.dart' as j;

@screenScope
@j.disposable
class NewChatViewModel extends BaseViewModel {
  @j.inject
  NewChatViewModel({
    required INewChatScreenRouter router,
  }) : _router = router;

  final INewChatScreenRouter _router;

  void onNewGroupTap() => _router.toCreateNewGroup();

  void onNewSecretChatTap() => _router.toCreateNewSecretChat();

  void onNewChannelTap() => _router.toCreateNewChannel();
}
