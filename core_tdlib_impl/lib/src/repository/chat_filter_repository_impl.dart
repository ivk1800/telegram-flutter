import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatFilterRepositoryImpl implements IChatFilterRepository {
  ChatFilterRepositoryImpl({
    required IChatFiltersUpdatesProvider chatFiltersUpdatesProvider,
  }) : _chatFiltersUpdatesProvider = chatFiltersUpdatesProvider {
    _init();
  }

  final IChatFiltersUpdatesProvider _chatFiltersUpdatesProvider;

  final BehaviorSubject<List<td.ChatFilterInfo>> _chatFiltersSubject =
      BehaviorSubject<List<td.ChatFilterInfo>>.seeded(<td.ChatFilterInfo>[]);

  StreamSubscription<List<td.ChatFilterInfo>>? _chatFiltersUpdatesSubscription;

  @override
  Stream<List<td.ChatFilterInfo>> get chatFiltersStream => _chatFiltersSubject;

  void _init() {
    _chatFiltersUpdatesSubscription = _chatFiltersUpdatesProvider
        .chatFiltersUpdates
        .map((td.UpdateChatFilters event) => event.chatFilters)
        .listen(_chatFiltersSubject.add);
  }

  void dispose() {
    _chatFiltersSubject.close();
    _chatFiltersUpdatesSubscription?.cancel();
  }
}
