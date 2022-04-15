library feature_profile_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/profile_feature_router.dart';
import 'src/screen/profile/profile_screen_factory.dart';

export 'src/profile_feature_router.dart';

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

class ProfileFeatureDependencies {
  ProfileFeatureDependencies({
    required this.userRepository,
    required this.chatHeaderInfoFeatureApi,
    required this.messageRepository,
    required this.chatRepository,
    required this.superGroupRepository,
    required this.basicGroupRepository,
    required this.localizationManager,
    required this.router,
  });

  final IUserRepository userRepository;

  final IBasicGroupRepository basicGroupRepository;

  final ISuperGroupRepository superGroupRepository;

  final IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi;

  final IChatMessageRepository messageRepository;

  final IChatRepository chatRepository;

  final ILocalizationManager localizationManager;

  final IProfileFeatureRouter router;
}
