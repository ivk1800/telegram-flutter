import 'package:feature_shared_media_impl/src/screen/factory/shared_media_screen_scope_delegate.dart';
import 'package:feature_shared_media_impl/src/shared_media_feature_dependencies.dmg.dart';
import 'package:jugger/jugger.dart' as j;

import 'shared_media_component_builder.dart';

@j.Component(
  modules: <Type>[SharedMediaFeatureDependenciesModule],
  builder: ISharedMediaComponentBuilder,
)
@j.singleton
abstract class ISharedMediaComponent
    implements ISharedMediaScreenScopeDelegate {}
