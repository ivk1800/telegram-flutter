library feature_notifications_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/src/notifications_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

import 'src/widget/factory/notifications_settings_widget_factory.dart';

export 'src/notifications_settings_screen_router.dart';

class NotificationsSettingsFeatureApi
    implements INotificationsSettingsFeatureApi {
  NotificationsSettingsFeatureApi(
      {required INotificationsSettingsFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            NotificationsSettingsWidgetFactory(dependencies: dependencies);

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
