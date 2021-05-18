import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/navigation/navigation.dart';

class ChatsListFeatureDependencies implements IChatsListFeatureDependencies {
  @j.inject
  ChatsListFeatureDependencies(
      {required IChatRepository chatRepository,
      required IChatUpdatesProvider chatUpdatesProvider,
      required DateFormatter dateFormatter,
      required DateParser dateParser,
      required IFileRepository fileRepository,
      required IChatsListScreenRouter router})
      : _chatRepository = chatRepository,
        _chatUpdatesProvider = chatUpdatesProvider,
        _dateFormatter = dateFormatter,
        _dateParser = dateParser,
        _fileRepository = fileRepository,
        _router = router;

  final IChatRepository _chatRepository;
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
}
