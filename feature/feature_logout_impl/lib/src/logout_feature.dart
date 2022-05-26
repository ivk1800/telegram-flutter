library feature_logout_impl;

import 'package:feature_logout_api/feature_logout_api.dart';

import 'logout_feature_dependencies.dart';
import 'screen/factory/logout_screen_factory.dart';

export 'logout_feature_router.dart';

class LogoutFeature implements ILogoutFeatureApi {
  LogoutFeature({
    required LogoutFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final LogoutFeatureDependencies _dependencies;
  late final LogoutScreenFactory _logoutScreenFactory =
      LogoutScreenFactory(dependencies: _dependencies);

  @override
  ILogoutScreenFactory get logoutScreenFactory => _logoutScreenFactory;
}
