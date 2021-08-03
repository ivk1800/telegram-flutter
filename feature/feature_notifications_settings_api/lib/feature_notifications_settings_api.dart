library feature_notifications_settings_api;

import 'package:flutter/widgets.dart';

abstract class INotificationsSettingsFeatureApi {
  INotificationsSettingsWidgetFactory get screenWidgetFactory;

  IQuickNotificationSettingsScreenFactory
      get quickNotificationSettingsScreenFactory;
}

abstract class INotificationsSettingsWidgetFactory {
  Widget create();
}

abstract class IQuickNotificationSettingsScreenFactory {
  Widget create({required BuildContext context});
}
