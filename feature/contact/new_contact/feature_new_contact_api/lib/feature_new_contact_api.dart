library feature_new_contact_api;

import 'package:flutter/widgets.dart';

abstract class INewContactFeatureApi {
  INewContactScreenFactory get newContactScreenFactory;
}

abstract class INewContactScreenFactory {
  Widget create(int userId);
}
