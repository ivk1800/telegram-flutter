library feature_contacts_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

import 'screen/contacts/contacts_router.dart';

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
