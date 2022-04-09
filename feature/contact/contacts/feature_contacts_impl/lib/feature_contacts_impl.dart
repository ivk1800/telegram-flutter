library feature_contacts_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_contacts_api/feature_contacts_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/contacts/contacts_router.dart';
import 'src/screen/contacts/contacts_screen_factory.dart';

export 'src/screen/contacts/contacts_router.dart';

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

class ContactsFeatureDependencies {
  ContactsFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.router,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final IContactsRouter router;
}
