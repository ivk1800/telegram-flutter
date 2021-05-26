library feature_notifications_settings_api;

import 'package:flutter/widgets.dart';

abstract class INotificationsSettingsFeatureApi {
  INotificationsSettingsWidgetFactory get screenWidgetFactory;
}

abstract class INotificationsSettingsWidgetFactory {
  Widget create();
}
