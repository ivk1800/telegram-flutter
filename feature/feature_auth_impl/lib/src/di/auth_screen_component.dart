import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_auth_impl/src/auth_feature_dependencies.dmg.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

import 'auth_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    AuthFeatureDependenciesModule,
    TgAppBarModule,
  ],
  builder: IAuthScreenComponentBuilder,
)
abstract class IAuthScreenComponent implements IAuthScreenScopeDelegate {}
