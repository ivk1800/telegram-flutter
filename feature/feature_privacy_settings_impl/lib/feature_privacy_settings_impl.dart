library feature_privacy_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_privacy_settings_impl/src/privacy_settings_screen_router.dart';
import 'package:feature_privacy_settings_impl/src/screen/privacy_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'src/di/privacy_settings_screen_component.dart';

export 'src/privacy_settings_screen_router.dart';

class PrivacySettingsFeatureApi implements IPrivacySettingsFeatureApi {
  PrivacySettingsFeatureApi(
      {required IPrivacySettingsFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

  final IPrivacySettingsWidgetFactory _settingsWidgetFactory;

  @override
  IPrivacySettingsWidgetFactory get screenWidgetFactory =>
      _settingsWidgetFactory;
}

abstract class IPrivacySettingsFeatureDependencies {
  ILocalizationManager get localizationManager;

  IPrivacySettingsScreenRouter get router;

  IConnectionStateProvider get connectionStateProvider;
}

class _ScreenWidgetFactory implements IPrivacySettingsWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final IPrivacySettingsFeatureDependencies dependencies;

  @override
  Widget create() => const PrivacySettingsPage().wrap(dependencies);
}
