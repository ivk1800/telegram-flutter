library feature_settings_search_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/src/settings_search_screen_router.dart';
import 'package:feature_settings_search_impl/src/widget/factory/settings_search_widget_factory.dart';
import 'package:localization_api/localization_api.dart';

export 'src/settings_search_screen_router.dart';

class SettingsSearchFeatureApi implements ISettingsSearchFeatureApi {
  SettingsSearchFeatureApi(
      {required ISettingsSearchFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            SearchSettingsWidgetFactory(dependencies: dependencies);

  final ISettingsSearchWidgetFactory _settingsWidgetFactory;

  @override
  ISettingsSearchWidgetFactory get screenWidgetFactory =>
      _settingsWidgetFactory;
}

abstract class ISettingsSearchFeatureDependencies {
  ILocalizationManager get localizationManager;

  ISettingsSearchScreenRouter get router;

  IConnectionStateProvider get connectionStateProvider;
}
