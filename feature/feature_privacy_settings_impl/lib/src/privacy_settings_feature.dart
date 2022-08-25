import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';

import 'privacy_settings_feature_dependencies.dart';
import 'widget/factory/privacy_settings_widget_factory.dart';

export 'privacy_settings_screen_router.dart';

class PrivacySettingsFeature implements IPrivacySettingsFeatureApi {
  PrivacySettingsFeature({
    required PrivacySettingsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final PrivacySettingsFeatureDependencies _dependencies;

  @override
  late final IPrivacySettingsWidgetFactory screenWidgetFactory =
      PrivacySettingsWidgetFactory(dependencies: _dependencies);
}
