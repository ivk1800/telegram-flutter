import 'package:chat_navigation_api/chat_router_api.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:profile_navigation_api/profile_navigation_api.dart';
import 'package:sticker_navigation_api/sticker_navigation_api.dart';

abstract class IChatScreenRouter
    implements
        IDialogRouter,
        IChatRouter,
        IProfileRouter,
        IStickersSetScreenRouter {
  void close();
}
