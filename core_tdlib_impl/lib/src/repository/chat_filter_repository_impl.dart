import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class ChatFilterRepositoryImpl implements IChatFilterRepository {
  @j.inject
  ChatFilterRepositoryImpl(
      {required IChatFiltersUpdatesProvider chatFiltersUpdatesProvider})
      : _chatFiltersUpdatesProvider = chatFiltersUpdatesProvider {
    _init();
  }

  final IChatFiltersUpdatesProvider _chatFiltersUpdatesProvider;

  List<td.ChatFilterInfo> _chatFilters = <td.ChatFilterInfo>[];

  void _init() {
    _chatFiltersUpdatesProvider.chatFiltersUpdates
        .listen((td.UpdateChatFilters event) {
      _chatFilters = event.chatFilters;
    });
  }

  @override
  List<td.ChatFilterInfo> get chatFilters => _chatFilters;
}
