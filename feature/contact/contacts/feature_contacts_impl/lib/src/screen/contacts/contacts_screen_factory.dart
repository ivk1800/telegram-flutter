import 'package:feature_contacts_api/feature_contacts_api.dart';
import 'package:feature_contacts_impl/feature_contacts_impl.dart';
import 'package:feature_contacts_impl/src/di/contacts_screen_component.jugger.dart';
import 'package:flutter/material.dart';

import 'contacts_page.dart';
import 'contacts_screen_scope_delegate.scope.dart';

class ContactsScreenFactory implements IContactsScreenFactory {
  ContactsScreenFactory({
    required ContactsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ContactsFeatureDependencies _dependencies;

  @override
  Widget create() {
    return ContactsScreenScope(
      child: const ContactsPage(),
      create: () => JuggerContactsScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
