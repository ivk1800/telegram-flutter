library feature_chat_impl;

import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:localization_api/localization_api.dart';

import 'chat_screen_router_factory.dart';

export 'package:profile_navigation_api/profile_navigation_api.dart';

@dependencies
class ChatFeatureDependencies {
  const ChatFeatureDependencies({
    required this.chatRepository,
    required this.fileRepository,
    required this.userRepository,
    required this.chatMessageRepository,
    required this.routerFactory,
    required this.dateParser,
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
    required this.optionsManager,
  });

  final IChatRepository chatRepository;
  final IFileRepository fileRepository;
  final IUserRepository userRepository;
  final IChatMessageRepository chatMessageRepository;
  final IChatScreenRouterFactory routerFactory;
  final DateParser dateParser;
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
  final OptionsManager optionsManager;
}
