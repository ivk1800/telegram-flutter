library feature_global_search_api;

import 'package:flutter/widgets.dart';

abstract class IMainScreenFeatureApi {
  IMainScreenWidgetFactory get screenWidgetFactory;
}

abstract class IMainScreenWidgetFactory {
  Widget create();
}
