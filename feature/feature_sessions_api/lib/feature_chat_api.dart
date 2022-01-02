library feature_sessions_api;

import 'package:flutter/widgets.dart';

abstract class ISessionsFeatureApi {
  ISessionsScreenFactory get sessionsScreenFactory;
}

abstract class ISessionsScreenFactory {
  Widget create();
}
