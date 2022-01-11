library feature_privacy_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_privacy_settings_impl/src/privacy_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

import 'src/widget/factory/privacy_settings_widget_factory.dart';

export 'src/privacy_settings_screen_router.dart';

class PrivacySettingsFeature implements IPrivacySettingsFeatureApi {
  PrivacySettingsFeature({
    required PrivacySettingsFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            PrivacySettingsWidgetFactory(dependencies: dependencies);

  final IPrivacySettingsWidgetFactory _settingsWidgetFactory;

  @override
  IPrivacySettingsWidgetFactory get screenWidgetFactory =>
      _settingsWidgetFactory;
}

class PrivacySettingsFeatureDependencies {
  const PrivacySettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final IPrivacySettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
