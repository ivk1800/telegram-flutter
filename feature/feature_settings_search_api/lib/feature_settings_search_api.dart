library feature_settings_search_api;

import 'package:flutter/widgets.dart';

abstract class ISettingsSearchFeatureApi {
  ISettingsSearchWidgetFactory get screenWidgetFactory;
}

abstract class ISettingsSearchWidgetFactory {
  Widget create();
}
