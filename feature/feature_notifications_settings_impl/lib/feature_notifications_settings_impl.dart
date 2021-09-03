library feature_notifications_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/src/notifications_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/factory/quick_notification_settings_screen_factory.dart';
import 'src/widget/factory/notifications_settings_widget_factory.dart';

export 'src/notifications_settings_screen_router.dart';

class NotificationsSettingsFeatureApi
    implements INotificationsSettingsFeatureApi {
  NotificationsSettingsFeatureApi(
      {required NotificationsSettingsFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            NotificationsSettingsWidgetFactory(dependencies: dependencies),
        _dependencies = dependencies;

  final NotificationsSettingsFeatureDependencies _dependencies;
  final INotificationsSettingsWidgetFactory _settingsWidgetFactory;
  QuickNotificationSettingsScreenFactory?
      _quickNotificationSettingsScreenFactory;

  @override
  INotificationsSettingsWidgetFactory get screenWidgetFactory =>
      _settingsWidgetFactory;

  @override
  IQuickNotificationSettingsScreenFactory
      get quickNotificationSettingsScreenFactory =>
          _quickNotificationSettingsScreenFactory ??
          QuickNotificationSettingsScreenFactory(
            dependencies: _dependencies,
          );
}

class NotificationsSettingsFeatureDependencies {
  const NotificationsSettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final INotificationsSettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
