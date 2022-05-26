library feature_settings_search_impl;

import 'package:feature_settings_search_api/feature_settings_search_api.dart';

import 'screen/settings_search_screen_factory.dart';
import 'settings_search_feature_dependencies.dart';

class SettingsSearchFeature implements ISettingsSearchFeatureApi {
  SettingsSearchFeature({
    required SettingsSearchFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            SearchSettingsScreenFactory(dependencies: dependencies);

  final ISettingsSearchScreenFactory _settingsWidgetFactory;

  @override
  ISettingsSearchScreenFactory get settingsSearchScreenFactory =>
      _settingsWidgetFactory;
}
