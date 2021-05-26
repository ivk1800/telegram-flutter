library feature_settings_search_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/src/settings_search_screen_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'src/di/settings_search_screen_component.dart';
import 'src/screen/settings_search_page.dart';

export 'src/settings_search_screen_router.dart';

class SettingsSearchFeatureApi implements ISettingsSearchFeatureApi {
  SettingsSearchFeatureApi(
      {required ISettingsSearchFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

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

class _ScreenWidgetFactory implements ISettingsSearchWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final ISettingsSearchFeatureDependencies dependencies;

  @override
  Widget create() => const SettingsSearchPage().wrap(dependencies);
}
