library feature_data_settings_api;

import 'package:flutter/widgets.dart';

abstract class IDataSettingsFeatureApi {
  IDataSettingsWidgetFactory get screenWidgetFactory;
}

abstract class IDataSettingsWidgetFactory {
  Widget create();
}
