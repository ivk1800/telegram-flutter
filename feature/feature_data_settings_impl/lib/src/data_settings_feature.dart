library feature_data_settings_impl;

import 'package:feature_data_settings_api/feature_data_settings_api.dart';

import 'data_settings_feature_dependencies.dart';
import 'widget/factory/data_settings_widget_factory.dart';

class DataSettingsFeature implements IDataSettingsFeatureApi {
  DataSettingsFeature({
    required DataSettingsFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            DataSettingsWidgetFactory(dependencies: dependencies);

  final IDataSettingsWidgetFactory _settingsWidgetFactory;

  @override
  IDataSettingsWidgetFactory get screenWidgetFactory => _settingsWidgetFactory;
}
