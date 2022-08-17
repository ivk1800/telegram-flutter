import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'settings_screen_component.dart';

@j.componentBuilder
abstract class ISettingsComponentBuilder {
  ISettingsComponentBuilder dependencies(
    SettingsFeatureDependencies dependencies,
  );

  ISettingsComponent build();
}
