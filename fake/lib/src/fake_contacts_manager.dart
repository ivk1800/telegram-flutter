import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeContactsManager implements IContactsManager {
  FakeContactsManager({required this.addContactCallback});

  final Future<void> Function(td.Contact contact, bool sharePhoneNumber)?
      addContactCallback;

  @override
  Future<void> addContact({
    required td.Contact contact,
    required bool sharePhoneNumber,
  }) =>
      addContactCallback?.call(contact, sharePhoneNumber) ??
      Future<td.Ok>.error('error');
}
