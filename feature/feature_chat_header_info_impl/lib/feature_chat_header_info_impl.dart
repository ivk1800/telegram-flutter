library feature_chat_header_info_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/chat_header_info_interactor.dart';

class ChatHeaderInfoFeatureDependencies {
  const ChatHeaderInfoFeatureDependencies({
    required this.chatRepository,
    required this.localizationManager,
    required this.basicGroupRepository,
    required this.superGroupRepository,
    required this.userRepository,
  });

  final IChatRepository chatRepository;

  final IUserRepository userRepository;

  final ILocalizationManager localizationManager;

  final IBasicGroupRepository basicGroupRepository;

  final ISuperGroupRepository superGroupRepository;
}

class ChatHeaderInfoFeatureApi implements IChatHeaderInfoFeatureApi {
  const ChatHeaderInfoFeatureApi(
      {required ChatHeaderInfoFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final ChatHeaderInfoFeatureDependencies _dependencies;

  @override
  IChatHeaderInfoInteractor getChatHeaderInfoInteractor(int chatId) =>
      ChatHeaderInfoInteractor(
        chatId: chatId,
        basicGroupRepository: _dependencies.basicGroupRepository,
        superGroupRepository: _dependencies.superGroupRepository,
        chatRepository: _dependencies.chatRepository,
        userRepository: _dependencies.userRepository,
        localizationManager: _dependencies.localizationManager,
      );
}
