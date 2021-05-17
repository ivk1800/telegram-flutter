library feature_global_search_api;

import 'package:flutter/widgets.dart';

abstract class IGlobalSearchFeatureApi {
  IGlobalSearchWidgetFactory get screenWidgetFactory;
}

abstract class IGlobalSearchWidgetFactory {
  Widget create();
}
