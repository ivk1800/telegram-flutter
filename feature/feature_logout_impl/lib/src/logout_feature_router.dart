import 'package:dialog_api/dialog_api.dart';

abstract class ILogoutFeatureRouter implements IDialogRouter {
  void toAddAccount();

  void toPasscodeSettings();

  void toStorageUsageSettings();

  void toChangeNumber();

  void toChat(int chatId);
}
