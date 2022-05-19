library feature_chat_impl;

import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:localization_api/localization_api.dart';

import 'feature_chat_impl.dart';
import 'src/widget/factory/chat_screen_factory.dart';

export 'package:profile_navigation_api/profile_navigation_api.dart';

export 'src/chat_screen_router.dart';
export 'src/chat_screen_router_factory.dart';
export 'src/component/message_mapper_component.dart';
export 'src/component/message_tile_factory_component.dart';
export 'src/mapper/message_tile_mapper.dart';
export 'src/screen/chat/message_action_listener.dart';
export 'src/tile/model/tile_model.dart';
export 'src/tile/widget/tile_widget.dart';
export 'src/wall/message_wall_context.dart';
export 'src/widget/chat_context.dart';

class ChatFeature implements IChatFeatureApi {
  ChatFeature({
    required ChatFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatFeatureDependencies _dependencies;
  late final IChatScreenFactory _chatScreenFactory =
      ChatScreenFactory(dependencies: _dependencies);
  @override
  IChatScreenFactory get chatScreenFactory => _chatScreenFactory;
}

class ChatFeatureDependencies {
  const ChatFeatureDependencies({
    required this.chatRepository,
    required this.fileRepository,
    required this.userRepository,
    required this.chatMessageRepository,
    required this.routerFactory,
    required this.dateFormatter,
    required this.dateParser,
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.messagePreviewResolver,
    required this.chatHeaderInfoFeatureApi,
    required this.fileDownloader,
    required this.functionExecutor,
    required this.superGroupRepository,
    required this.basicGroupRepository,
    required this.superGroupUpdatesProvider,
    required this.basicGroupUpdatesProvider,
    required this.chatUpdatesProvider,
    required this.chatMessagesUpdatesProvider,
    required this.chatManager,
    required this.errorTransformer,
  });

  final IChatRepository chatRepository;

  final IFileRepository fileRepository;

  final IUserRepository userRepository;

  final IChatMessageRepository chatMessageRepository;

  final IChatScreenRouterFactory routerFactory;

  final DateFormatter dateFormatter;

  final DateParser dateParser;

  final IConnectionStateProvider connectionStateProvider;

  final IStringsProvider stringsProvider;

  final IMessagePreviewResolver messagePreviewResolver;

  final IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi;

  final IFileDownloader fileDownloader;

  final ITdFunctionExecutor functionExecutor;

  final ISuperGroupRepository superGroupRepository;

  final IBasicGroupRepository basicGroupRepository;

  final ISuperGroupUpdatesProvider superGroupUpdatesProvider;

  final IBasicGroupUpdatesProvider basicGroupUpdatesProvider;

  final IChatUpdatesProvider chatUpdatesProvider;

  final IChatMessagesUpdatesProvider chatMessagesUpdatesProvider;

  final IChatManager chatManager;

  final IErrorTransformer errorTransformer;
}
