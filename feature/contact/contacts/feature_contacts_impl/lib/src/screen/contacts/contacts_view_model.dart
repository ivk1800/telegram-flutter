import 'package:core_arch/core_arch.dart';
import 'package:jugger/jugger.dart' as j;
import 'contacts_router.dart';

@j.singleton
@j.disposable
class ContactsViewModel extends BaseViewModel {
  @j.inject
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
