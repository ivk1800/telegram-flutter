import 'package:feature_auth_api/feature_auth_api.dart';

import 'auth_feature_dependencies.dart';
import 'screen/factory/auth_screen_factory.dart';

class AuthFeature implements IAuthFeatureApi {
  AuthFeature({required AuthFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final AuthFeatureDependencies _dependencies;
  late final AuthScreenFactory _authScreenFactory =
      AuthScreenFactory(dependencies: _dependencies);

  @override
  IAuthScreenFactory get authScreenFactory => _authScreenFactory;
}
