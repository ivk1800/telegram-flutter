library theme_manager_api;

import 'package:theme_manager_api/src/theme.dart';

export 'src/theme.dart';

abstract class IThemeManager {
  set theme(Theme value);
  Theme get theme;
}
