library feature_change_username_api;

import 'package:flutter/widgets.dart';

abstract class IChangeUsernameFeatureApi {
  IChangeUsernameScreenFactory get changeUsernameScreenFactory;
}

abstract class IChangeUsernameScreenFactory {
  Widget create();
}
