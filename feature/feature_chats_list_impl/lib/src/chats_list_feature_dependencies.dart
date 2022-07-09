import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:feature_chats_list_impl/src/chats_list_screen_router.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:flutter/foundation.dart';

@dependencies
@immutable
class ChatsListFeatureDependencies {
  const ChatsListFeatureDependencies({
    required this.chatRepository,
    required this.fileDownloader,
    required this.router,
    required this.dateFormatter,
    required this.dateParser,
    required this.chatUpdatesProvider,
    required this.messagePreviewResolver,
    required this.superGroupRepository,
  });

  final IChatRepository chatRepository;

  final IFileDownloader fileDownloader;

  final IChatsListScreenRouter router;

  final DateFormatter dateFormatter;

  final DateParser dateParser;

  final IChatUpdatesProvider chatUpdatesProvider;

  final IMessagePreviewResolver messagePreviewResolver;

  final ISuperGroupRepository superGroupRepository;
}
