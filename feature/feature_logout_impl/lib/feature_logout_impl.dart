library feature_logout_impl;

import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/logout_feature_router.dart';
import 'src/screen/factory/logout_screen_factory.dart';

export 'src/logout_feature_router.dart';

class LogoutFeatureApi implements ILogoutFeatureApi {
  LogoutFeatureApi({
    required LogoutFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final LogoutFeatureDependencies _dependencies;
  LogoutScreenFactory? _logoutScreenFactory;

  @override
  ILogoutScreenFactory get logoutScreenFactory =>
      _logoutScreenFactory ??= LogoutScreenFactory(dependencies: _dependencies);
}

class LogoutFeatureDependencies {
  LogoutFeatureDependencies({
    required this.localizationManager,
    required this.authenticationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;
  final IAuthenticationManager authenticationManager;
  final ILogoutFeatureRouter router;
  final IConnectionStateProvider connectionStateProvider;
}
