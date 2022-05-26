import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_notifications_settings_impl/src/notifications_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

class NotificationsSettingsFeatureDependencies {
  const NotificationsSettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final INotificationsSettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
