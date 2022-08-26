library feature_profile_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'profile_feature_router.dart';

@immutable
@dependencies
class ProfileFeatureDependencies {
  const ProfileFeatureDependencies({
    required this.userRepository,
    required this.chatHeaderInfoFeatureApi,
    required this.messageRepository,
    required this.chatRepository,
    required this.superGroupRepository,
    required this.basicGroupRepository,
    required this.stringsProvider,
    required this.router,
  });

  final IUserRepository userRepository;

  final IBasicGroupRepository basicGroupRepository;

  final ISuperGroupRepository superGroupRepository;

  final IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi;

  final IChatMessageRepository messageRepository;

  final IChatRepository chatRepository;

  final IStringsProvider stringsProvider;

  final IProfileFeatureRouter router;
}
