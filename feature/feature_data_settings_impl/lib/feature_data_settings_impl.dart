library feature_data_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_data_settings_impl/src/data_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

import 'src/widget/factory/data_settings_widget_factory.dart';

export 'src/data_settings_screen_router.dart';

class DataSettingsFeature implements IDataSettingsFeatureApi {
  DataSettingsFeature({
    required DataSettingsFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            DataSettingsWidgetFactory(dependencies: dependencies);

  final IDataSettingsWidgetFactory _settingsWidgetFactory;

  @override
  IDataSettingsWidgetFactory get screenWidgetFactory => _settingsWidgetFactory;
}

class DataSettingsFeatureDependencies {
  const DataSettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final IDataSettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
