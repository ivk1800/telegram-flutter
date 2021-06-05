import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:feature_chat_settings_impl/src/chat_settings_screen_router.dart';

class ChatSettingsViewModel extends BaseViewModel {
  @j.inject
  ChatSettingsViewModel({required IChatSettingsScreenRouter router})
      : _router = router;
  final IChatSettingsScreenRouter _router;

  void onStickersAndMasksTap() => _router.toStickersAndMasks();
}
