import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/di/scope/screen_scope.dart';
import 'package:showcase/src/showcase_list/showcase_list_scope_delegate.dart';

import 'showcase_list_screen_component_builder.dart';
import 'showcase_list_screen_module.dart';

@j.Subcomponent(
  modules: <Type>[ShowcaseListScreenModule],
  builder: IShowcaseListScreenComponentBuilder,
)
@screenScope
abstract class IShowcaseListScreenComponent
    implements IShowcaseListScreenScopeDelegate {}
