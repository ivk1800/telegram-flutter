import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

import 'active_background_storage.dart';
import 'chat_background.dart';

class ChatBackgroundManager {
  ChatBackgroundManager({
    required IBackgroundRepository backgroundRepository,
    required ActiveBackgroundStorage activeBackgroundStorage,
    required IAuthenticationStateUpdatesProvider
        authenticationStateUpdatesProvider,
    required IAuthenticationStateProvider authenticationStateProvider,
  })  : _backgroundRepository = backgroundRepository,
        _authenticationStateUpdatesProvider =
            authenticationStateUpdatesProvider,
        _activeBackgroundStorage = activeBackgroundStorage,
        _authenticationStateProvider = authenticationStateProvider {
    _init();
  }

  StreamSubscription<dynamic>? _streamSubscription;
  final PublishSubject<int> _publishSubject = PublishSubject<int>();

  final BehaviorSubject<ChatBackground> _backgroundSubject =
      BehaviorSubject<ChatBackground>.seeded(const ChatBackground.none());

  final IAuthenticationStateUpdatesProvider _authenticationStateUpdatesProvider;
  final IBackgroundRepository _backgroundRepository;
  final ActiveBackgroundStorage _activeBackgroundStorage;
  final IAuthenticationStateProvider _authenticationStateProvider;

  ChatBackground get background => _backgroundSubject.value;

  Stream<ChatBackground> get backgroundStream => _backgroundSubject;

  void setActiveBackground(int id) {
    _activeBackgroundStorage.value = id;
    _publishSubject.add(id);
  }

  void _init() {
    _streamSubscription = _publishSubject
        .startWith(_activeBackgroundStorage.value)
        .switchMap((int id) {
      return _authenticationStateUpdatesProvider.authorizationStateUpdates
          .map(
            (td.UpdateAuthorizationState update) => update.authorizationState,
          )
          .startWith(_authenticationStateProvider.authorizationState)
          .where(
            (td.AuthorizationState state) => state.maybeMap(
              ready: (td.AuthorizationStateReady value) => true,
              orElse: () => false,
            ),
          )
          .distinct()
          .take(1)
          .asyncMap((_) async {
        if (id == -1) {
          final List<td.Background> backgrounds =
              await _backgroundRepository.backgrounds;
          assert(backgrounds.isNotEmpty);
          final td.Background background = backgrounds.first;
          return background;
        }
        return _backgroundRepository.getBackground(id);
      }).doOnData((td.Background background) {
        _activeBackgroundStorage.value = background.id;
      }).map((td.Background background) {
        return const ChatBackground.none();
      });
    }).listen(_backgroundSubject.add);
  }

  void dispose() {
    _streamSubscription?.cancel();
    _publishSubject.close();
    _backgroundSubject.close();
  }
}
