library feature_chats_list_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/src/chats_list_screen_router.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list/chats_list_screen_factory.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:localization_api/localization_api.dart';

export 'src/chats_list_screen_router.dart';
export 'src/tile/chat_tile.dart';
export 'src/tile/chat_tile_model.dart';

class ChatsListFeature implements IChatsListFeatureApi {
  ChatsListFeature({
    required ChatsListFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  late final IChatsListScreenFactory _chatsListScreenFactory =
      ChatsListScreenFactory(dependencies: _dependencies);

  final ChatsListFeatureDependencies _dependencies;

  @override
  IChatsListScreenFactory get chatsListScreenFactory => _chatsListScreenFactory;
}

class ChatsListFeatureDependencies {
  const ChatsListFeatureDependencies({
    required this.chatRepository,
    required this.fileRepository,
    required this.router,
    required this.dateFormatter,
    required this.dateParser,
    required this.chatUpdatesProvider,
    required this.userRepository,
    required this.localizationManager,
    required this.messagePreviewResolver,
  });

  final IChatRepository chatRepository;

  final IFileRepository fileRepository;

  final IChatsListScreenRouter router;

  final DateFormatter dateFormatter;

  final DateParser dateParser;

  final IChatUpdatesProvider chatUpdatesProvider;

  final IUserRepository userRepository;

  final ILocalizationManager localizationManager;

  final IMessagePreviewResolver messagePreviewResolver;
}
