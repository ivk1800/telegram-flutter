import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/src/date_formatter.dart';
import 'package:core_utils/src/date_parser.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
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
      required IChatRepository chatRepository,
      required IConnectionStateProvider connectionStateProvider})
      : _fileRepository = fileRepository,
        _dateParser = dateParser,
        _userRepository = userRepository,
        _localizationManager = localizationManager,
        _dateFormatter = dateFormatter,
        _chatRepository = chatRepository,
        _chatMessageRepository = chatMessageRepository,
        _router = router,
        _connectionStateProvider = connectionStateProvider;

  final IFileRepository _fileRepository;
  final IChatMessageRepository _chatMessageRepository;
  final IConnectionStateProvider _connectionStateProvider;
  final IChatScreenRouter _router;
  final DateParser _dateParser;
  final DateFormatter _dateFormatter;
  final IChatRepository _chatRepository;
  final ILocalizationManager _localizationManager;
  final IUserRepository _userRepository;

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
}
