import 'package:feature_global_search_impl/src/global_search_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'global_search_screen_component.dart';

@j.componentBuilder
abstract class IGlobalSearchScreenComponentBuilder {
  IGlobalSearchScreenComponentBuilder dependencies(
    GlobalSearchFeatureDependencies dependencies,
  );

  IGlobalSearchScreenComponent build();
}
