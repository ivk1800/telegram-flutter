import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/widgets.dart';

enum ScreenState { chats, search }

class AppBarKey extends GlobalObjectKey<tg.TgSwitchedAppBarState> {
  const AppBarKey(super.value);
}
