library feature_chats_list_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/src/chats_list_screen_router.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list_page.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'src/di/chats_list_screen_component.dart';

export 'src/chats_list_screen_router.dart';
export 'src/tile/chat_tile.dart';
export 'src/tile/chat_tile_model.dart';

class ChatsListFeatureApi implements IChatsListFeatureApi {
  ChatsListFeatureApi({
    required ChatsListFeatureDependencies dependencies,
  }) : _chatsListWidgetFactory =
            _ChatsListWidgetFactory(dependencies: dependencies);

  final IChatsListWidgetFactory _chatsListWidgetFactory;

  @override
  IChatsListWidgetFactory get screenWidgetFactory => _chatsListWidgetFactory;
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

class _ChatsListWidgetFactory implements IChatsListWidgetFactory {
  _ChatsListWidgetFactory({required this.dependencies});

  final ChatsListFeatureDependencies dependencies;

  @override
  Widget create() => const ChatsListPage().wrap(dependencies);
}
