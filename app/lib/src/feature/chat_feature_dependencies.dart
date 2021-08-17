import 'package:app/src/feature/feature.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:feature_message_preview_resolver_impl/feature_message_preview_resolver_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class ChatFeatureDependencies implements IChatFeatureDependencies {
  @j.inject
  ChatFeatureDependencies(
      {required IFileRepository fileRepository,
      required IChatMessageRepository chatMessageRepository,
      required IChatScreenRouter router,
      required DateParser dateParser,
      required IUserRepository userRepository,
      required ILocalizationManager localizationManager,
      required DateFormatter dateFormatter,
      required FeatureFactory featureFactory,
      required IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
      required IChatRepository chatRepository,
      required IConnectionStateProvider connectionStateProvider})
      : _fileRepository = fileRepository,
        _dateParser = dateParser,
        // todo move to app component global scope
        _fileDownloader = featureFactory.createFileFeatureApi().fileDownloader,
        _userRepository = userRepository,
        _localizationManager = localizationManager,
        _dateFormatter = dateFormatter,
        _chatRepository = chatRepository,
        _chatHeaderInfoFeatureApi = chatHeaderInfoFeatureApi,
        _chatMessageRepository = chatMessageRepository,
        _router = router,
        _messagePreviewResolver = MessagePreviewResolver(
            messageRepository: chatMessageRepository,
            mode: Mode.ReplyPreview,
            chatRepository: chatRepository,
            userRepository: userRepository,
            localizationManager: localizationManager),
        _connectionStateProvider = connectionStateProvider;

  final IMessagePreviewResolver _messagePreviewResolver;
  final IFileRepository _fileRepository;
  final IChatMessageRepository _chatMessageRepository;
  final IConnectionStateProvider _connectionStateProvider;
  final IChatScreenRouter _router;
  final DateParser _dateParser;
  final DateFormatter _dateFormatter;
  final IChatRepository _chatRepository;
  final ILocalizationManager _localizationManager;
  final IUserRepository _userRepository;
  final IChatHeaderInfoFeatureApi _chatHeaderInfoFeatureApi;
  final IFileDownloader _fileDownloader;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;

  @override
  IChatMessageRepository get chatMessageRepository => _chatMessageRepository;

  @override
  IChatRepository get chatRepository => _chatRepository;

  @override
  DateFormatter get dateFormatter => _dateFormatter;

  @override
  DateParser get dateParser => _dateParser;

  @override
  IFileRepository get fileRepository => _fileRepository;

  @override
  IChatScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IUserRepository get userRepository => _userRepository;

  @override
  IMessagePreviewResolver get messagePreviewResolver => _messagePreviewResolver;

  @override
  IChatHeaderInfoFeatureApi get chatHeaderInfoFeatureApi =>
      _chatHeaderInfoFeatureApi;

  @override
  IFileDownloader get fileDownloader => _fileDownloader;
}
