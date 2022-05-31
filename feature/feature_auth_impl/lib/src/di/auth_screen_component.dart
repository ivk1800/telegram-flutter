import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_screen_vidget_model.dart';
import 'package:feature_auth_impl/src/screen/auth/view_model/auth_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[AuthScreenModule],
)
abstract class IAuthScreenComponent {
  AuthViewModel getAuthViewModel();

  IStringsProvider getStringsProvider();

  AuthScreenWidgetModel getAuthScreenWidgetModel();
}

@j.module
abstract class AuthScreenModule {
  @j.provides
  @j.singleton
  static AuthViewModel provideAuthViewModel(
    AuthFeatureDependencies dependencies,
  ) =>
      AuthViewModel(
        errorTransformer: dependencies.errorTransformer,
        stringsProvider: dependencies.stringsProvider,
        router: dependencies.router,
        authenticationManager: dependencies.authenticationManager,
        countryRepository: dependencies.countryRepository,
      );

  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    AuthFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;
}

@j.componentBuilder
abstract class IAuthScreenComponentBuilder {
  IAuthScreenComponentBuilder dependencies(
    AuthFeatureDependencies dependencies,
  );

  IAuthScreenComponent build();
}
