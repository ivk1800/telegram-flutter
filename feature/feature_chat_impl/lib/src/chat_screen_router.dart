import 'package:chat_router_api/chat_router_api.dart';
import 'package:dialog_api/dialog_api.dart';

abstract class IChatScreenRouter implements IDialogRouter, IChatRouter {
  void toChatProfile(int chatId);

  void close();
}
