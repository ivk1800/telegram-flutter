import 'package:feature_global_search_impl/src/global_search_feature_dependencies.dmg.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

import 'global_search_screen_component_builder.dart';
import 'global_search_screen_module.dart';

@j.Component(
  modules: <Type>[
    GlobalSearchScreenModule,
    GlobalSearchFeatureDependenciesModule,
  ],
  builder: IGlobalSearchScreenComponentBuilder,
)
@j.singleton
abstract class IGlobalSearchScreenComponent
    implements IGlobalSearchScreenScopeDelegate {}
