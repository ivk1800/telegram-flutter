library feature_settings_search_api;

import 'package:flutter/widgets.dart';

abstract class ISettingsSearchFeatureApi {
  ISettingsSearchScreenFactory get settingsSearchScreenFactory;
}

abstract class ISettingsSearchScreenFactory {
  Widget create(SettingsSearchScreenController controller);
}

class SettingsSearchScreenController {
  ValueNotifier<String> queryValue = ValueNotifier<String>('');

  // ignore: use_setters_to_change_properties
  void onQuery(String query) {
    queryValue.value = query;
  }

  void dispose() {
    queryValue.dispose();
  }
}
