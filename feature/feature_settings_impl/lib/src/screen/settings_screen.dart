import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/widgets.dart';

class AppBarKey extends GlobalObjectKey<tg.TgSwitchedAppBarState> {
  const AppBarKey(Object value) : super(value);
}

enum AppBarMenu { logOut }

enum ScreenState { settings, search }
