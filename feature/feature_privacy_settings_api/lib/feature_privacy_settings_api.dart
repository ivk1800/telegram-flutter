library feature_privacy_settings_api;

import 'package:flutter/widgets.dart';

abstract class IPrivacySettingsFeatureApi {
  IPrivacySettingsWidgetFactory get screenWidgetFactory;
}

abstract class IPrivacySettingsWidgetFactory {
  Widget create();
}
