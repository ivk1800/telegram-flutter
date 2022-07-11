import 'package:feature_contacts_impl/src/screen/contacts/contacts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'contacts_screen_scope_delegate.scope.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactsViewModel contactsViewModel =
        ContactsScreenScope.getContactsViewModel(context);
    final IStringsProvider stringsProvider =
        ContactsScreenScope.getStringsProvider(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.contacts),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(stringsProvider.inviteFriends),
            onTap: contactsViewModel.onInviteFriendsTap,
          ),
          ListTile(
            title: Text(stringsProvider.addPeopleNearby),
            onTap: contactsViewModel.onFindPeopleNearbyTap,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: contactsViewModel.onAddContactTap,
      ),
    );
  }
}
