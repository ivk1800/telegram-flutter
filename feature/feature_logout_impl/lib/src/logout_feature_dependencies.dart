import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

import 'logout_feature_router.dart';

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
