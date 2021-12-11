import 'dart:async';

import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatActionPanelInteractor implements IChatActionPanelInteractor {
  ChatActionPanelInteractor({
    required int chatId,
    required IChatRepository chatRepository,
    required ISuperGroupRepository superGroupRepository,
    required IBasicGroupRepository basicGroupRepository,
  })  : _chatId = chatId,
        _superGroupRepository = superGroupRepository,
        _basicGroupRepository = basicGroupRepository,
        _chatRepository = chatRepository {
    _beginListen();
  }

  final int _chatId;
  final IChatRepository _chatRepository;
  final ISuperGroupRepository _superGroupRepository;
  final IBasicGroupRepository _basicGroupRepository;
  StreamSubscription<PanelState>? _subscription;

  final BehaviorSubject<PanelState> _stateSubject =
      BehaviorSubject<PanelState>.seeded(const PanelState.empty());

  @override
  Stream<PanelState> get panelStateStream => _stateSubject;

  @override
  void dispose() {
    _stateSubject.close();
    _subscription?.cancel();
  }

  void _beginListen() {
    final Stream<PanelState> map =
        Stream<td.Chat>.fromFuture(_chatRepository.getChat(_chatId))
            .map((td.Chat chat) {
      return const PanelState.empty();
    });

    _subscription = map.listen(_stateSubject.add);
  }
}
