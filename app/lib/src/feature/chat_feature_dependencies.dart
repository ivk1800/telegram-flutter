import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/src/date_formatter.dart';
import 'package:core_utils/src/date_parser.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:jugger/jugger.dart' as j;

class ChatFeatureDependencies implements IChatFeatureDependencies {
  @j.inject
  ChatFeatureDependencies(
      {required IFileRepository fileRepository,
      required IChatMessageRepository chatMessageRepository,
      required IChatScreenRouter router,
      required DateParser dateParser,
      required DateFormatter dateFormatter,
      required IChatRepository chatRepository,
      required IConnectionStateUpdatesProvider connectionStateUpdatesProvider})
      : _fileRepository = fileRepository,
        _dateParser = dateParser,
        _dateFormatter = dateFormatter,
        _chatRepository = chatRepository,
        _chatMessageRepository = chatMessageRepository,
        _router = router,
        _connectionStateUpdatesProvider = connectionStateUpdatesProvider;

  final IFileRepository _fileRepository;
  final IChatMessageRepository _chatMessageRepository;
  final IConnectionStateUpdatesProvider _connectionStateUpdatesProvider;
  final IChatScreenRouter _router;
  final DateParser _dateParser;
  final DateFormatter _dateFormatter;
  final IChatRepository _chatRepository;

  @override
  IConnectionStateUpdatesProvider get connectionStateUpdatesProvider =>
      _connectionStateUpdatesProvider;

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
}
