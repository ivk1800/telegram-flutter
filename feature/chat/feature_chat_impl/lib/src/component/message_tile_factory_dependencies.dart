import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:feature_chat_impl/src/chat_screen_router.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:localization_api/localization_api.dart';

import 'message_action_listener.dart';

@dependencies
class MessageTileFactoryDependencies {
  const MessageTileFactoryDependencies({
    required this.stringsProvider,
    required this.messageWallContext,
    required this.messageActionListener,
    required this.fileDownloader,
    required this.chatScreenRouter,
    required this.stickerRepository,
  });

  final IStringsProvider stringsProvider;
  final IMessageWallContext messageWallContext;
  final IMessageActionListener messageActionListener;
  final IFileDownloader fileDownloader;
  final IChatScreenRouter chatScreenRouter;
  final IStickerRepository stickerRepository;
}
