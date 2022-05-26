import 'package:feature_contacts_api/feature_contacts_api.dart';

import 'contacts_feature_dependencies.dart';
import 'screen/contacts/contacts_screen_factory.dart';

class ContactsFeature implements IContactsFeatureApi {
  ContactsFeature({
    required ContactsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ContactsFeatureDependencies _dependencies;
  late final ContactsScreenFactory _contactsScreenFactory =
      ContactsScreenFactory(dependencies: _dependencies);

  @override
  IContactsScreenFactory get contactsScreenFactory => _contactsScreenFactory;
}
