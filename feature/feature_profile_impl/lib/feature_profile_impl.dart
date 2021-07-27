library feature_profile_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';

import 'src/screen/factory/profile_screen_factory.dart';

class ProfileFeatureApi implements IProfileFeatureApi {
  ProfileFeatureApi({required ProfileFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final ProfileFeatureDependencies _dependencies;
  ProfileScreenFactory? _profileScreenFactory;

  @override
  IProfileScreenFactory get profileScreenFactory =>
      _profileScreenFactory ??= ProfileScreenFactory(
        dependencies: _dependencies,
      );
}

class ProfileFeatureDependencies {
  ProfileFeatureDependencies({
    required this.userRepository,
    required this.chatHeaderInfoFeatureApi,
  });

  final IUserRepository userRepository;

  final IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi;
}
