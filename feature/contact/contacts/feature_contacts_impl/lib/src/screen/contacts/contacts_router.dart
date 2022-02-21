import 'package:chat_router_api/chat_router_api.dart';

abstract class IContactsRouter implements IChatRouter {
  void toAddContact();

  void toFindPeopleNearby();

  void toInviteFriends();
}
