import 'notifications_settings_widget_factory.dart';
import 'quick_notification_settings_screen_factory.dart';

abstract class INotificationsSettingsFeatureApi {
  INotificationsSettingsWidgetFactory get screenWidgetFactory;

  IQuickNotificationSettingsScreenFactory
      get quickNotificationSettingsScreenFactory;
}
