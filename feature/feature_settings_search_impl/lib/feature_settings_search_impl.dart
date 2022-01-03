library feature_settings_search_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/src/settings_search_screen_router.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/settings_search_screen_factory.dart';

export 'src/settings_search_screen_router.dart';

class SettingsSearchFeatureApi implements ISettingsSearchFeatureApi {
  SettingsSearchFeatureApi({
    required SettingsSearchFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            SearchSettingsScreenFactory(dependencies: dependencies);

  final ISettingsSearchScreenFactory _settingsWidgetFactory;

  @override
  ISettingsSearchScreenFactory get settingsSearchScreenFactory =>
      _settingsWidgetFactory;
}

class SettingsSearchFeatureDependencies {
  const SettingsSearchFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final ISettingsSearchScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
