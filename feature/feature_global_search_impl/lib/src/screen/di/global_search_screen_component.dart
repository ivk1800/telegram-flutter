import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_view_model.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_widget_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

import 'global_search_screen_module.dart';

@j.Component(
  modules: <Type>[GlobalSearchScreenModule],
)
abstract class IGlobalSearchScreenComponent {
  TileFactory getTileFactory();

  GlobalSearchWidgetModel getGlobalSearchWidgetModel();

  GlobalSearchViewModel getGlobalSearchViewModel();

  IStringsProvider getStringsProvider();
}

@j.componentBuilder
abstract class IGlobalSearchScreenComponentBuilder {
  IGlobalSearchScreenComponentBuilder dependencies(
    GlobalSearchFeatureDependencies dependencies,
  );

  IGlobalSearchScreenComponent build();
}
