import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/widgets.dart';

class AppBarKey extends GlobalObjectKey<tg.TgSwitchedAppBarState> {
  const AppBarKey(super.value);
}

enum AppBarMenu { logOut }

enum ScreenState { settings, search }
