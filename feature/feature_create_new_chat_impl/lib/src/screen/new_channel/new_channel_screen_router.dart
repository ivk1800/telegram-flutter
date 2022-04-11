import 'package:dialog_api/dialog_api.dart';

abstract class INewChannelScreenRouter implements IDialogRouter {
  void closeAfterCreateChannel(int chatId);
}
