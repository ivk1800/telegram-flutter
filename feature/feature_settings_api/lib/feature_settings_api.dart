library feature_settings_api;

import 'package:flutter/widgets.dart';

abstract class ISettingsFeatureApi {
  ISettingsWidgetFactory get screenWidgetFactory;
}

abstract class ISettingsWidgetFactory {
  Widget create();
}
