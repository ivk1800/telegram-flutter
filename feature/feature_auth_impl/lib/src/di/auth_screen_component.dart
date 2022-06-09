import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/auth_feature_dependencies.dmg.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_screen_vidget_model.dart';
import 'package:feature_auth_impl/src/screen/auth/view_model/auth_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[
    AuthScreenModule,
    AuthFeatureDependenciesModule,
    TgAppBarModule,
  ],
)
abstract class IAuthScreenComponent {
  AuthViewModel getAuthViewModel();

  IStringsProvider getStringsProvider();

  AuthScreenWidgetModel getAuthScreenWidgetModel();

  tg.TgAppBarFactory getTgAppBarFactory();

  ScopeDisposer get scopeDisposer;
}

@j.module
abstract class AuthScreenModule {
  @j.provides
  @j.singleton
  static ScopeDisposer provideScopeDisposer(
    AuthViewModel authViewModel,
    AuthScreenWidgetModel authScreenWidgetModel,
  ) =>
      ScopeDisposer()
        ..registerDisposableCallback(() {
          authViewModel.dispose();
        })
        ..registerDisposableCallback(() {
          authScreenWidgetModel.dispose();
        });
}

@j.componentBuilder
abstract class IAuthScreenComponentBuilder {
  IAuthScreenComponentBuilder dependencies(
    AuthFeatureDependencies dependencies,
  );

  IAuthScreenComponent build();
}
