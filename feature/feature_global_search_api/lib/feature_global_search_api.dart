// ignore_for_file: use_setters_to_change_properties
library feature_global_search_api;

import 'package:flutter/widgets.dart';

abstract class IGlobalSearchFeatureApi {
  IGlobalSearchScreenFactory get globalSearchScreenFactory;
}

abstract class IGlobalSearchScreenFactory {
  Widget create(BuildContext context, GlobalSearchScreenController controller);
}

class GlobalSearchScreenController {
  ValueNotifier<String> queryValue = ValueNotifier<String>('');

  void onQuery(String query) {
    queryValue.value = query;
  }

  void dispose() {
    queryValue.dispose();
  }
}
