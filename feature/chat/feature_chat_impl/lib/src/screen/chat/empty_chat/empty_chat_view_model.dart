import 'dart:async';

import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:core/core.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_impl/src/di/chat_qualifiers.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

import 'empty_state.dart';

@j.singleton
class EmptyChatViewModel extends BaseViewModel {
  @j.inject
  EmptyChatViewModel({
    @chatIdQualifier required int chatId,
    required IChatRepository chatRepository,
    required OptionsManager optionsManager,
  })  : _chatId = chatId,
        _chatRepository = chatRepository,
        _optionsManager = optionsManager {
    _init();
  }

  final int _chatId;
  final IChatRepository _chatRepository;
  final OptionsManager _optionsManager;

  final BehaviorSubject<EmptyState> _stateSubject =
      BehaviorSubject<EmptyState>();

  Stream<EmptyState> get state => _stateSubject;

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }

  void _init() {
    final CancelableOperation<EmptyState> operation =
        _chatRepository.getChat(_chatId).toCancelableOperation().map(
      (td.Chat value) {
        // TODO: implement others states: admin of channel, greeting state...
        return value.type.maybeMap<FutureOr<EmptyState>>(
          private: (td.ChatTypePrivate private) async {
            final int myId = await _optionsManager.getMyId();
            if (private.userId == myId) {
              return const EmptyState.self();
            }
            return const EmptyState.common();
          },
          orElse: () {
            return const EmptyState.common();
          },
        );
      },
    ).onValue(_stateSubject.add);
    attach(operation);
  }
}
