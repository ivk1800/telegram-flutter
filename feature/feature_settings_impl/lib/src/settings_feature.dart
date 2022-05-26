import 'package:feature_settings_api/feature_settings_api.dart';

import 'screen/settings_screen_factory.dart';
import 'settings_feature_dependencies.dart';

class SettingsFeature implements ISettingsFeatureApi {
  SettingsFeature({
    required SettingsFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            SettingsScreenFactory(dependencies: dependencies);

  final ISettingScreenFactory _settingsWidgetFactory;

  @override
  ISettingScreenFactory get settingsScreenFactory => _settingsWidgetFactory;
}
