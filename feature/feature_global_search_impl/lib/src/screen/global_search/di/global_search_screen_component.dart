import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/cubit/global_search_cubit.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

import 'global_search_screen_module.dart';

@j.Component(
  modules: <Type>[GlobalSearchScreenModule],
)
abstract class IGlobalSearchScreenComponent {
  TileFactory getTileFactory();

  GlobalSearchCubit getGlobalSearchCubit();

  ILocalizationManager getLocalizationManager();
}

@j.componentBuilder
abstract class IGlobalSearchScreenComponentBuilder {
  IGlobalSearchScreenComponentBuilder dependencies(
    GlobalSearchFeatureDependencies dependencies,
  );

  IGlobalSearchScreenComponent build();
}
