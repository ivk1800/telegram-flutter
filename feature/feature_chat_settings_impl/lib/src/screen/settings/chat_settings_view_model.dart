import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_settings_impl/src/chat_settings_screen_router.dart';

import 'chat_settings_event.dart';

class ChatSettingsViewModel extends BaseViewModel {
  ChatSettingsViewModel({
    required IChatSettingsScreenRouter router,
  }) : _router = router;

  final IChatSettingsScreenRouter _router;

  void onEvent(ChatSettingsEvent event) {
    event.when(
      stickersAndMasksTap: () {
        _router.toStickersAndMasks();
      },
      wallpapersTap: () {
        _router.toWallPapers();
      },
    );
  }
}
