import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'new_contact_screen_scope.dart';
import 'new_contact_view_model.dart';

class NewContactPage extends StatelessWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewContactViewModel contactsViewModel =
        NewContactScreenScope.getNewContactsViewModel(context);
    IStringsProvider stringsProvider =
        NewContactScreenScope.getStringsProvider(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.addContactTitle),
      ),
    );
  }
}
