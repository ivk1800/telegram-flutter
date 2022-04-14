import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class ContactsManager implements IContactsManager {
  const ContactsManager({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<void> addContact({
    required td.Contact contact,
    required bool sharePhoneNumber,
  }) =>
      _functionExecutor.send(td.AddContact(
        contact: contact,
        sharePhoneNumber: sharePhoneNumber,
      ));
}
