library feature_auth_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/auth_feature_router.dart';
import 'src/authentication_manager.dart';
import 'src/screen/factory/auth_screen_factory.dart';

export 'src/auth_feature_router.dart';
export 'src/authentication_manager.dart';

class AuthFeatureApi implements IAuthFeatureApi {
  AuthFeatureApi({required AuthFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final AuthFeatureDependencies _dependencies;
  AuthScreenFactory? _authScreenFactory;

  AuthenticationManager? _authenticationManager;

  @override
  IAuthScreenFactory get authScreenFactory =>
      _authScreenFactory ??= AuthScreenFactory(dependencies: _dependencies);

  @override
  IAuthenticationManager get authenticationManager =>
      _authenticationManager ??= AuthenticationManager(
        functionExecutor: _dependencies.functionExecutor,
        authenticationStateUpdatesProvider:
            _dependencies.authenticationStateUpdatesProvider,
      );
}

class AuthFeatureDependencies {
  AuthFeatureDependencies({
    required this.connectionStateProvider,
    required this.localizationManager,
    required this.router,
    required this.functionExecutor,
    required this.authenticationStateUpdatesProvider,
    required this.countryRepository,
  });

  final IConnectionStateProvider connectionStateProvider;
  final ILocalizationManager localizationManager;
  final IAuthFeatureRouter router;
  final ITdFunctionExecutor functionExecutor;
  final IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider;
  final ICountryRepository countryRepository;
}
