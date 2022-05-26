// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/foundation.dart';

class GlobalSearchScreenController {
  ValueNotifier<String> queryValue = ValueNotifier<String>('');

  void onQuery(String query) {
    queryValue.value = query;
  }

  void dispose() {
    queryValue.dispose();
  }
}
