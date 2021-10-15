library feature_global_search_api;

import 'package:flutter/widgets.dart';

abstract class IMainScreenFeatureApi {
  IMainScreenFactory get mainScreenFactory;
}

abstract class IMainScreenFactory {
  Widget create();
}
