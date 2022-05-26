import 'package:flutter/foundation.dart';

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
