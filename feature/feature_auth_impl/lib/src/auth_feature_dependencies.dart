library feature_auth_impl;

import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:localization_api/localization_api.dart';

import 'auth_feature_router.dart';

class AuthFeatureDependencies {
  AuthFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.router,
    required this.authenticationStateUpdatesProvider,
    required this.countryRepository,
    required this.authenticationManager,
    required this.errorTransformer,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final IAuthFeatureRouter router;
  final IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider;
  final ICountryRepository countryRepository;
  final IAuthenticationManager authenticationManager;
  final IErrorTransformer errorTransformer;
}
