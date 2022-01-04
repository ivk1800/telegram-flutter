library feature_logout_api;

import 'package:flutter/widgets.dart';

abstract class ILogoutFeatureApi {
  ILogoutScreenFactory get logoutScreenFactory;
}

abstract class ILogoutScreenFactory {
  Widget create();
}
