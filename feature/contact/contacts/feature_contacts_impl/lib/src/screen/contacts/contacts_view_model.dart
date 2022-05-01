import 'package:core_arch/core_arch.dart';

import 'contacts_router.dart';

class ContactsViewModel extends BaseViewModel {
  ContactsViewModel({
    required IContactsRouter router,
  }) : _router = router;

  final IContactsRouter _router;

  void onInviteFriendsTap() {
    _router.toInviteFriends();
  }

  void onAddContactTap() {
    _router.toAddContact();
  }

  void onFindPeopleNearbyTap() {
    _router.toFindPeopleNearby();
  }
}
