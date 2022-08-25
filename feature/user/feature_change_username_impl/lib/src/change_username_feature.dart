library feature_change_username_impl;

import 'package:feature_change_username_api/feature_change_username_api.dart';

import 'change_username_feature_dependencies.dart';
import 'screen/change_username/change_username_screen_factory.dart';

export 'change_username_router.dart';

class ChangeUsernameFeature implements IChangeUsernameFeatureApi {
  ChangeUsernameFeature({
    required ChangeUsernameFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChangeUsernameFeatureDependencies _dependencies;

  @override
  late final IChangeUsernameScreenFactory changeUsernameScreenFactory =
      ChangeUsernameScreenFactory(dependencies: _dependencies);
}
