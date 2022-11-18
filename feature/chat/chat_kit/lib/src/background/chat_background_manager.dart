import 'dart:async';
import 'dart:ui';

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

  StreamSubscription<dynamic>? _changeBackgroundEventSubscription;
  final PublishSubject<int> _changeBackgroundEventSubject =
      PublishSubject<int>();

  final BehaviorSubject<ChatBackground> _backgroundSubject =
      BehaviorSubject<ChatBackground>.seeded(const ChatBackground.none());

  final IAuthenticationStateUpdatesProvider _authenticationStateUpdatesProvider;
  final IBackgroundRepository _backgroundRepository;
  final ActiveBackgroundStorage _activeBackgroundStorage;
  final IAuthenticationStateProvider _authenticationStateProvider;

  ChatBackground get background => _backgroundSubject.value;

  Stream<ChatBackground> get backgroundStream => _backgroundSubject.distinct();

  void setActiveBackground(int id) {
    if (_activeBackgroundStorage.value != id) {
      _activeBackgroundStorage.value = id;
      _changeBackgroundEventSubject.add(id);
    }
  }

  void _init() {
    _changeBackgroundEventSubscription = _changeBackgroundEventSubject
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
        return background.type.map(
          wallpaper: (_) {
            return const ChatBackground.none();
          },
          pattern: (_) {
            return const ChatBackground.none();
          },
          fill: (td.BackgroundTypeFill value) {
            return value.fill.map(
              solid: (td.BackgroundFillSolid value) {
                return ChatBackground.solid(
                  color: _rgb24ToColor(value.color),
                );
              },
              gradient: (_) {
                return const ChatBackground.none();
              },
              freeformGradient: (td.BackgroundFillFreeformGradient value) {
                return ChatBackground.freeformGradient(
                  colors:
                      value.colors.map(_rgb24ToColor).toList(growable: false),
                );
              },
            );
          },
        );
      });
    }).listen(_backgroundSubject.add);
  }

  Color _rgb24ToColor(int color) {
    final int red = (color >> 16) & 255;
    final int green = (color >> 8) & 255;
    final int blue = color & 255;
    return Color.fromARGB(255, red, green, blue);
  }

  void dispose() {
    _changeBackgroundEventSubscription?.cancel();
    _changeBackgroundEventSubject.close();
    _backgroundSubject.close();
  }
}
