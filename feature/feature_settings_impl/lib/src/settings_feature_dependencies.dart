import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_settings_impl/src/settings_screen_router.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:localization_api/localization_api.dart';

class SettingsFeatureDependencies {
  const SettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.settingsSearchFeatureApi,
    required this.fileDownloader,
    required this.userRepository,
    required this.optionsManager,
  });

  final ILocalizationManager localizationManager;
  final ISettingsScreenRouter router;
  final ISettingsSearchFeatureApi settingsSearchFeatureApi;
  final IFileDownloader fileDownloader;
  final IUserRepository userRepository;
  final OptionsManager optionsManager;
}
