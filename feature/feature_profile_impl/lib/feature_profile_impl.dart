library feature_profile_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:localization_api/localization_api.dart';

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
    required this.messageRepository,
    required this.chatRepository,
    required this.superGroupRepository,
    required this.basicGroupRepository,
    required this.localizationManager,
  });

  final IUserRepository userRepository;

  final IBasicGroupRepository basicGroupRepository;

  final ISuperGroupRepository superGroupRepository;

  final IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi;

  final IChatMessageRepository messageRepository;

  final IChatRepository chatRepository;

  final ILocalizationManager localizationManager;
}
