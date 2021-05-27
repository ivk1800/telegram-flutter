library feature_data_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_data_settings_impl/src/data_settings_screen_router.dart';
import 'package:feature_data_settings_impl/src/screen/data_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'src/di/data_settings_screen_component.dart';

export 'src/data_settings_screen_router.dart';

class DataSettingsFeatureApi implements IDataSettingsFeatureApi {
  DataSettingsFeatureApi(
      {required IDataSettingsFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

  final IDataSettingsWidgetFactory _settingsWidgetFactory;

  @override
  IDataSettingsWidgetFactory get screenWidgetFactory => _settingsWidgetFactory;
}

abstract class IDataSettingsFeatureDependencies {
  ILocalizationManager get localizationManager;

  IDataSettingsScreenRouter get router;

  IConnectionStateProvider get connectionStateProvider;
}

class _ScreenWidgetFactory implements IDataSettingsWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final IDataSettingsFeatureDependencies dependencies;

  @override
  Widget create() => const DataSettingsPage().wrap(dependencies);
}
