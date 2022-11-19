import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

import 'active_background_storage.dart';
import 'chat_background.dart';
import 'pattern_background_file_resolver.dart';

class ChatBackgroundManager {
  ChatBackgroundManager({
    required IBackgroundRepository backgroundRepository,
    required ActiveBackgroundStorage activeBackgroundStorage,
    required IAuthenticationStateUpdatesProvider
        authenticationStateUpdatesProvider,
    required IAuthenticationStateProvider authenticationStateProvider,
    required IFileDownloader fileDownloader,
    required PatternBackgroundFileResolver patternBackgroundFileResolver,
  })  : _backgroundRepository = backgroundRepository,
        _authenticationStateUpdatesProvider =
            authenticationStateUpdatesProvider,
        _activeBackgroundStorage = activeBackgroundStorage,
        _authenticationStateProvider = authenticationStateProvider,
        _patternBackgroundFileResolver = patternBackgroundFileResolver,
        _fileDownloader = fileDownloader {
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
  final IFileDownloader _fileDownloader;
  final PatternBackgroundFileResolver _patternBackgroundFileResolver;

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
      }).asyncMap((td.Background background) async {
        return background.type.map(
          wallpaper: (_) {
            return Future<ChatBackground>.value(const ChatBackground.none());
          },
          pattern: (td.BackgroundTypePattern value) {
            return _mapPatternToBackground(
              background: background,
              pattern: value,
            );
          },
          fill: (td.BackgroundTypeFill value) {
            return Future<ChatBackground>.value(
              _mapFillToBackground(value.fill),
            );
          },
        );
      });
    }).listen(_backgroundSubject.add);
  }

  Future<ChatBackground> _mapPatternToBackground({
    required td.Background background,
    required td.BackgroundTypePattern pattern,
  }) async {
    final td.Document? document = background.document;
    assert(document != null);
    if (document!.mimeType == 'application/x-tgwallpattern') {
      final File tgvFile =
          await _fileDownloader.downloadFile(document.document.id);
      final File pngFile = await _patternBackgroundFileResolver.resolve(
        backgroundId: background.id,
        tgvFile: tgvFile,
      );
      return ChatBackground.pattern(file: pngFile);
    } else {
      // TODO support png
      return const ChatBackground.none();
    }
  }

  ChatBackground _mapFillToBackground(td.BackgroundFill fill) {
    return fill.map(
      solid: (td.BackgroundFillSolid value) {
        return ChatBackground.solid(
          color: value.color.toColor(),
        );
      },
      gradient: (_) {
        return const ChatBackground.none();
      },
      freeformGradient: (td.BackgroundFillFreeformGradient value) {
        return ChatBackground.freeformGradient(
          colors: value.colors.map((int color) => color.toColor()).toList(
                growable: false,
              ),
        );
      },
    );
  }

  void dispose() {
    _changeBackgroundEventSubscription?.cancel();
    _changeBackgroundEventSubject.close();
    _backgroundSubject.close();
  }
}
