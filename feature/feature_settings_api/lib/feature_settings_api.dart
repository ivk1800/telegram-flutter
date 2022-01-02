library feature_settings_api;

import 'package:flutter/widgets.dart';

abstract class ISettingsFeatureApi {
  ISettingScreenFactory get settingsScreenFactory;
}

abstract class ISettingScreenFactory {
  Widget create();
}
