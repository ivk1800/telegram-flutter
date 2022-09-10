library feature_chat_header_info_impl;

import 'package:core_presentation/core_presentation.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';

import 'chat_header_info_factory.dart';
import 'chat_header_info_feature_dependencies.dart';
import 'chat_header_info_interactor.dart';

class ChatHeaderInfoFeature implements IChatHeaderInfoFeatureApi {
  const ChatHeaderInfoFeature({
    required ChatHeaderInfoFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

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
        avatarResolver: AvatarResolver(
          optionsManager: _dependencies.optionsManager,
        ),
      );

  @override
  IChatHeaderInfoFactory getChatHeaderInfoFactory() => ChatHeaderInfoFactory(
        avatarWidgetFactory: tg.AvatarWidgetFactory(
          fileDownloader: _dependencies.fileDownloader,
        ),
        connectionStateWidgetFactory: tg.ConnectionStateWidgetFactory(
          connectionStateProvider: _dependencies.connectionStateProvider,
        ),
      );
}
