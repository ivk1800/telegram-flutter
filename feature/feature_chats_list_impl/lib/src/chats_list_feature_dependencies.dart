import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/src/chats_list_screen_router.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:localization_api/localization_api.dart';

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
    required this.superGroupRepository,
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

  final ISuperGroupRepository superGroupRepository;
}
