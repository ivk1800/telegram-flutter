library feature_new_contact_api;

import 'package:flutter/widgets.dart';

abstract class IChatAdministrationFeatureApi {
  IChatAdministrationScreenFactory get chatAdministrationScreenFactory;
}

abstract class IChatAdministrationScreenFactory {
  Widget create(int chatId);
}
