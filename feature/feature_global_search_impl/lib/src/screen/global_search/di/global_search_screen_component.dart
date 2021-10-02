import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/bloc/global_search_bloc.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

import 'global_search_screen_module.dart';

@j.Component(modules: <Type>[
  GlobalSearchScreenModule,
])
abstract class GlobalSearchScreenComponent {
  TileFactory getTileFactory();

  GlobalSearchBloc getGlobalSearchBloc();

  ILocalizationManager getLocalizationManager();
}

@j.componentBuilder
abstract class GlobalSearchScreenComponentBuilder {
  GlobalSearchScreenComponentBuilder dependencies(
    GlobalSearchFeatureDependencies dependencies,
  );

  GlobalSearchScreenComponent build();
}
