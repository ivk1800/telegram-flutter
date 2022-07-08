import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/auth_feature_dependencies.dmg.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Component(
  modules: <Type>[
    AuthFeatureDependenciesModule,
    TgAppBarModule,
  ],
)
abstract class IAuthScreenComponent implements IAuthScreenScopeDelegate {}

@j.componentBuilder
abstract class IAuthScreenComponentBuilder {
  IAuthScreenComponentBuilder dependencies(
    AuthFeatureDependencies dependencies,
  );

  IAuthScreenComponent build();
}
