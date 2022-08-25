import 'package:feature_contacts_api/feature_contacts_api.dart';

import 'contacts_feature_dependencies.dart';
import 'screen/contacts/contacts_screen_factory.dart';

class ContactsFeature implements IContactsFeatureApi {
  ContactsFeature({
    required ContactsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ContactsFeatureDependencies _dependencies;

  @override
  late final IContactsScreenFactory contactsScreenFactory =
      ContactsScreenFactory(dependencies: _dependencies);
}
