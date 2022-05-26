import 'package:feature_profile_api/feature_profile_api.dart';

import 'profile_feature_dependencies.dart';
import 'screen/profile/profile_screen_factory.dart';

class ProfileFeature implements IProfileFeatureApi {
  ProfileFeature({required ProfileFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final ProfileFeatureDependencies _dependencies;
  late final ProfileScreenFactory _profileScreenFactory = ProfileScreenFactory(
    dependencies: _dependencies,
  );

  @override
  IProfileScreenFactory get profileScreenFactory => _profileScreenFactory;
}
