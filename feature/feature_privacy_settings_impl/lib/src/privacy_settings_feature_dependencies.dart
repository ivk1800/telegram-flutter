import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_privacy_settings_impl/src/privacy_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

export 'privacy_settings_screen_router.dart';

class PrivacySettingsFeatureDependencies {
  const PrivacySettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final IPrivacySettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
