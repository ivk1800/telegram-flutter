library feature_settings_impl;

import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/src/settings_screen_router.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/settings_screen_factory.dart';

export 'src/settings_screen_router.dart';

class SettingsFeature implements ISettingsFeatureApi {
  SettingsFeature({
    required SettingsFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            SettingsScreenFactory(dependencies: dependencies);

  final ISettingScreenFactory _settingsWidgetFactory;

  @override
  ISettingScreenFactory get settingsScreenFactory => _settingsWidgetFactory;
}

class SettingsFeatureDependencies {
  const SettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.settingsSearchFeatureApi,
    required this.fileRepository,
    required this.userRepository,
    required this.optionsManager,
  });

  final ILocalizationManager localizationManager;
  final ISettingsScreenRouter router;
  final ISettingsSearchFeatureApi settingsSearchFeatureApi;
  final IFileRepository fileRepository;
  final IUserRepository userRepository;
  final OptionsManager optionsManager;
}
