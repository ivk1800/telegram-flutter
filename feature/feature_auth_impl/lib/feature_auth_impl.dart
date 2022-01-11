library feature_auth_impl;

import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/auth_feature_router.dart';
import 'src/screen/factory/auth_screen_factory.dart';

export 'src/auth_feature_router.dart';

class AuthFeature implements IAuthFeatureApi {
  AuthFeature({required AuthFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final AuthFeatureDependencies _dependencies;
  late final AuthScreenFactory _authScreenFactory =
      AuthScreenFactory(dependencies: _dependencies);

  @override
  IAuthScreenFactory get authScreenFactory => _authScreenFactory;
}

class AuthFeatureDependencies {
  AuthFeatureDependencies({
    required this.connectionStateProvider,
    required this.localizationManager,
    required this.router,
    required this.authenticationStateUpdatesProvider,
    required this.countryRepository,
    required this.authenticationManager,
  });

  final IConnectionStateProvider connectionStateProvider;
  final ILocalizationManager localizationManager;
  final IAuthFeatureRouter router;
  final IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider;
  final ICountryRepository countryRepository;
  final IAuthenticationManager authenticationManager;
}
