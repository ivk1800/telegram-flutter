import 'package:flutter/foundation.dart';
import 'package:theme_manager_api/theme_manager_api.dart';

class ThemeManager extends ValueNotifier<Theme> implements IThemeManager {
  ThemeManager() : super(const Theme.classic());

  @override
  Theme get theme => value;

  @override
  set theme(Theme value) {
    this.value = value;
  }
}
