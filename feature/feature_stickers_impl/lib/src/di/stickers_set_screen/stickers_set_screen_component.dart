import 'package:feature_stickers_impl/src/di/scope/screen_scope.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/stickers_set_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

import 'stickers_set_screen_component_builder.dart';
import 'stickers_set_screen_module.dart';

@j.Subcomponent(
  modules: <Type>[StickersSetScreenModule],
  builder: IStickersSetScreenComponentBuilder,
)
@screenScope
abstract class IStickersSetScreenComponent
    implements IStickersSetScreenScopeDelegate {}
