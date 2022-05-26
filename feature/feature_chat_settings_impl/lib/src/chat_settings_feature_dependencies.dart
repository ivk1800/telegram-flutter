import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_settings_impl/src/chat_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

class ChatSettingsFeatureDependencies {
  const ChatSettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final IChatSettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
