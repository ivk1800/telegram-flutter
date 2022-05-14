import 'package:jugger/jugger.dart' as j;
import 'package:theme_manager_flutter/theme_manager_flutter.dart';

@j.module
abstract class ThemeModule {
  @j.singleton
  @j.provides
  static ThemeManager provideThemeManager() => ThemeManager();

  @j.singleton
  @j.provides
  static ThemeDataResolver provideThemeDataResolver() =>
      const ThemeDataResolver();

  @j.singleton
  @j.binds
  IThemeManager bindThemeManager(ThemeManager impl);
}
