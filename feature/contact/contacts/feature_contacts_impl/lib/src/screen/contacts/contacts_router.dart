import 'package:chat_navigation_api/chat_router_api.dart';

abstract class IContactsRouter implements IChatRouter {
  void toAddContact();

  void toFindPeopleNearby();

  void toInviteFriends();
}
