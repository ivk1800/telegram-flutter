import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/screen/auth/bloc/auth_bloc.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[ProfileScreenModule],
)
abstract class IAuthScreenComponent {
  AuthBloc getProfileBloc();

  ILocalizationManager getLocalizationManager();
}

@j.module
abstract class ProfileScreenModule {
  @j.provides
  @j.singleton
  static AuthBloc provideProfileBloc(
    AuthFeatureDependencies dependencies,
  ) =>
      AuthBloc(
        localizationManager: dependencies.localizationManager,
        router: dependencies.router,
        authenticationManager: dependencies.authenticationManager,
        countryRepository: dependencies.countryRepository,
      );

  @j.provides
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    AuthFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;
}

@j.componentBuilder
abstract class IAuthScreenComponentBuilder {
  IAuthScreenComponentBuilder dependencies(
    AuthFeatureDependencies dependencies,
  );

  IAuthScreenComponent build();
}
