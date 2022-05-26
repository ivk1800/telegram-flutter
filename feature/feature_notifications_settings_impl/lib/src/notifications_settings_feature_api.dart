import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';

import 'notifications_settings_feature_dependencies.dart';
import 'screen/factory/quick_notification_settings_screen_factory.dart';
import 'widget/factory/notifications_settings_widget_factory.dart';

export 'notifications_settings_screen_router.dart';

class NotificationsSettingsFeatureApi
    implements INotificationsSettingsFeatureApi {
  NotificationsSettingsFeatureApi({
    required NotificationsSettingsFeatureDependencies dependencies,
  })  : _settingsWidgetFactory =
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
