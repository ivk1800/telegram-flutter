library feature_contacts_api;

import 'package:flutter/widgets.dart';

abstract class IContactsFeatureApi {
  IContactsScreenFactory get contactsScreenFactory;
}

abstract class IContactsScreenFactory {
  Widget create();
}
