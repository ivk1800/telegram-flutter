import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_stickers_impl/src/stickers_feature_dependencies.dmg.dart';
import 'package:feature_stickers_impl/src/stickers_feature_router.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'scope/feature_scope.dart';
import 'stickers_component_builder.dart';
import 'stickers_set_screen/stickers_set_screen_component.dart';
import 'stickers_set_screen/stickers_set_screen_component_builder.dart';

@j.Component(
  modules: <Type>[StickersFeatureDependenciesModule],
  builder: IStickersComponentBuilder,
)
@featureScope
abstract class IStickersComponent {
  IStringsProvider getStringsProvider();

  //TODO
  IStickersFeatureRouter get stickersFeatureRouter;

  //TODO
  IConnectionStateProvider get connectionStateProvider;

  @j.subcomponentFactory
  IStickersSetScreenComponent createStickersSetScreenComponent(
    IStickersSetScreenComponentBuilder builder,
  );
}
