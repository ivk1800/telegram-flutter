import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:feature_message_preview_resolver_impl/feature_message_preview_resolver_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:presentation/src/navigation/navigation.dart';

class ChatsListFeatureDependencies implements IChatsListFeatureDependencies {
  @j.inject
  ChatsListFeatureDependencies(
      {required IChatRepository chatRepository,
      required IUserRepository userRepository,
      required IChatMessageRepository chatMessageRepository,
      required ILocalizationManager localizationManager,
      required IChatUpdatesProvider chatUpdatesProvider,
      required DateFormatter dateFormatter,
      required DateParser dateParser,
      required IFileRepository fileRepository,
      required IChatsListScreenRouter router})
      : _chatRepository = chatRepository,
        _userRepository = userRepository,
        _localizationManager = localizationManager,
        _chatUpdatesProvider = chatUpdatesProvider,
        _dateFormatter = dateFormatter,
        _dateParser = dateParser,
        _fileRepository = fileRepository,
        _messagePreviewResolver = MessagePreviewResolver(
            messageRepository: chatMessageRepository,
            chatRepository: chatRepository,
            mode: Mode.ChatPreview,
            userRepository: userRepository,
            localizationManager: localizationManager),
        _router = router;

  final IMessagePreviewResolver _messagePreviewResolver;
  final IChatRepository _chatRepository;
  final IUserRepository _userRepository;
  final ILocalizationManager _localizationManager;
  final IChatUpdatesProvider _chatUpdatesProvider;
  final DateFormatter _dateFormatter;
  final DateParser _dateParser;
  final IFileRepository _fileRepository;
  final IChatsListScreenRouter _router;

  @override
  IChatRepository get chatRepository => _chatRepository;

  @override
  IChatUpdatesProvider get chatUpdatesProvider => _chatUpdatesProvider;

  @override
  DateFormatter get dateFormatter => _dateFormatter;

  @override
  DateParser get dateParser => _dateParser;

  @override
  IFileRepository get fileRepository => _fileRepository;

  @override
  IChatsListScreenRouter get router => _router;

  @override
  IUserRepository get userRepository => _userRepository;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IMessagePreviewResolver get messagePreviewResolver => _messagePreviewResolver;
}
