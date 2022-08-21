import 'package:app/src/di/scope/application_scope.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:theme_manager_flutter/theme_manager_flutter.dart';

@j.module
abstract class ThemeModule {
  @applicationScope
  @j.provides
  static ThemeManager provideThemeManager() => ThemeManager();

  @applicationScope
  @j.provides
  static ThemeDataResolver provideThemeDataResolver() =>
      const ThemeDataResolver();

  @applicationScope
  @j.binds
  IThemeManager bindThemeManager(ThemeManager impl);
}
