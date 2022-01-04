import 'package:chat_router_api/chat_router_api.dart';

abstract class IChatsListScreenRouter implements IChatRouter {
  @override
  void toChat(int chatId);
}
