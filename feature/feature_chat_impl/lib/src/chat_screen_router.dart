import 'package:dialog_api/dialog_api.dart';

abstract class IChatScreenRouter implements IDialogRouter {
  void toChat(int id);

  void toChatProfile(int chatId);

  void back();
}
