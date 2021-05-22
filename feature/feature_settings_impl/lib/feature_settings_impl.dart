library feature_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/src/settings_screen_router.dart';
import 'package:feature_settings_impl/src/screen/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'src/di/settings_screen_component.dart';

export 'src/settings_screen_router.dart';

class SettingsFeatureApi implements ISettingsFeatureApi {
  SettingsFeatureApi({required ISettingsFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

  final ISettingsWidgetFactory _settingsWidgetFactory;

  @override
  ISettingsWidgetFactory get screenWidgetFactory => _settingsWidgetFactory;
}

abstract class ISettingsFeatureDependencies {
  ILocalizationManager get localizationManager;

  ISettingsScreenRouter get router;

  IConnectionStateUpdatesProvider get connectionStateUpdatesProvider;
}

class _ScreenWidgetFactory implements ISettingsWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final ISettingsFeatureDependencies dependencies;

  @override
  Widget create() => const SettingsPage().wrap(dependencies);
}
