import 'package:tdlib/td_api.dart' as td;

abstract class IContactsManager {
  Future<void> addContact({
    required td.Contact contact,
    required bool sharePhoneNumber,
  });
}
