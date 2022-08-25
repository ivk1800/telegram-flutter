import 'package:feature_settings_api/feature_settings_api.dart';

import 'screen/settings_screen_factory.dart';
import 'settings_feature_dependencies.dart';

class SettingsFeature implements ISettingsFeatureApi {
  SettingsFeature({
    required SettingsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SettingsFeatureDependencies _dependencies;

  @override
  late final ISettingScreenFactory settingsScreenFactory =
      SettingsScreenFactory(dependencies: _dependencies);
}
