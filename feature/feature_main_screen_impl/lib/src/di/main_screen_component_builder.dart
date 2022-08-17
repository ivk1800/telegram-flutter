import 'package:feature_main_screen_impl/src/main_screen_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'main_screen_component.dart';

@j.componentBuilder
abstract class IMainScreenComponentBuilder {
  IMainScreenComponentBuilder dependencies(
    MainScreenFeatureDependencies dependencies,
  );

  IMainScreenComponent build();
}
