import 'package:feature_contacts_impl/src/contacts_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'contacts_screen_component.dart';

@j.componentBuilder
abstract class IContactsScreenComponentBuilder {
  IContactsScreenComponentBuilder dependencies(
    ContactsFeatureDependencies dependencies,
  );

  IContactsScreenComponent build();
}
