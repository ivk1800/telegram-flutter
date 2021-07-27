library feature_profile_api;

import 'package:flutter/widgets.dart';

abstract class IProfileFeatureApi {
  IProfileScreenFactory get profileScreenFactory;
}

abstract class IProfileScreenFactory {
  Widget create(BuildContext context, int id);
}
