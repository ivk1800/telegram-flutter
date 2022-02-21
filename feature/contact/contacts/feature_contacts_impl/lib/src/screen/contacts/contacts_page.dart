import 'package:feature_contacts_impl/src/screen/contacts/contacts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'contacts_screen_scope.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactsViewModel contactsViewModel =
        ContactsScreenScope.getContactsViewModel(context);
    IStringsProvider stringsProvider =
        ContactsScreenScope.getStringsProvider(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.contacts),
      ),
      body: Column(
        children: [
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
        child: Icon(Icons.person_add),
        onPressed: contactsViewModel.onAddContactTap,
      ),
    );
  }
}
