import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:theme_manager_api/theme_manager_api.dart';

// todo add distinct
class ThemeManager extends ValueNotifier<Theme> implements IThemeManager {
  ThemeManager() : super(const Theme.classic());

  late final BehaviorSubject<Theme> _themeSubject =
      BehaviorSubject<Theme>.seeded(value);

  @override
  Theme get theme => value;

  @override
  set theme(Theme value) {
    _themeSubject.value = value;
    this.value = value;
  }

  @override
  Stream<Theme> get themeStream => _themeSubject;

  @override
  void dispose() {
    _themeSubject.close();
    super.dispose();
  }
}
