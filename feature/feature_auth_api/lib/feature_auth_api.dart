library feature_auth_api;

import 'package:flutter/widgets.dart';

abstract class IAuthFeatureApi {
  IAuthScreenFactory get authScreenFactory;
}

abstract class IAuthScreenFactory {
  Widget create();
}
