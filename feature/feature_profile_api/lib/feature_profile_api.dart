library feature_profile_api;

import 'package:flutter/widgets.dart';
import 'package:profile_navigation_api/profile_navigation_api.dart';

export 'package:profile_navigation_api/profile_navigation_api.dart';

abstract class IProfileFeatureApi {
  IProfileScreenFactory get profileScreenFactory;
}

abstract class IProfileScreenFactory {
  Widget create(int id, ProfileType type);
}
