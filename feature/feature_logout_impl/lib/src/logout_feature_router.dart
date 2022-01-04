import 'package:chat_router_api/chat_router_api.dart';
import 'package:dialog_api/dialog_api.dart';

abstract class ILogoutFeatureRouter implements IDialogRouter, IChatRouter {
  void toAddAccount();

  void toPasscodeSettings();

  void toStorageUsageSettings();

  void toChangeNumber();

  @override
  void toChat(int chatId);
}
