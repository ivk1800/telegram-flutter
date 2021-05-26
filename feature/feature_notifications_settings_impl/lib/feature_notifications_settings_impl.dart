library feature_notifications_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/src/notifications_settings_screen_router.dart';
import 'package:flutter/widgets.dart';
import 'src/di/notifications_settings_screen_component.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/notifications_settings_page.dart';

export 'src/notifications_settings_screen_router.dart';

class NotificationsSettingsFeatureApi
    implements INotificationsSettingsFeatureApi {
  NotificationsSettingsFeatureApi(
      {required INotificationsSettingsFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

  final INotificationsSettingsWidgetFactory _settingsWidgetFactory;

  @override
  INotificationsSettingsWidgetFactory get screenWidgetFactory =>
      _settingsWidgetFactory;
}

abstract class INotificationsSettingsFeatureDependencies {
  ILocalizationManager get localizationManager;

  INotificationsSettingsScreenRouter get router;

  IConnectionStateProvider get connectionStateProvider;
}

class _ScreenWidgetFactory implements INotificationsSettingsWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final INotificationsSettingsFeatureDependencies dependencies;

  @override
  Widget create() => const NotificationsSettingsPage().wrap(dependencies);
}
