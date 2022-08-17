import 'package:feature_settings_search_impl/src/settings_search_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'settings_search_screen_component.dart';

@j.componentBuilder
abstract class ISearchSettingsScreenComponentBuilder {
  ISearchSettingsScreenComponentBuilder dependencies(
    SettingsSearchFeatureDependencies dependencies,
  );

  ISettingsSearchScreenComponent build();
}
