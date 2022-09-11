import 'package:feature_stickers_impl/src/stickers_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'stickers_component.dart';

@j.componentBuilder
abstract class IStickersComponentBuilder {
  IStickersComponentBuilder dependencies(
    StickersFeatureDependencies dependencies,
  );

  IStickersComponent build();
}
