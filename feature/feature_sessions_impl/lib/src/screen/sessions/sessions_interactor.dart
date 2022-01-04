import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_state.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

import 'session_tile_mapper.dart';

class SessionsInteractor {
  @j.inject
  SessionsInteractor({
    required ISessionRepository sessionRepository,
    required SessionTileMapper sessionTileMapper,
  })  : _sessionRepository = sessionRepository,
        _sessionTileMapper = sessionTileMapper {
    _stateSubscription = _getSessionsStream().listen(_stateSubject.add);
  }

  final ISessionRepository _sessionRepository;
  final SessionTileMapper _sessionTileMapper;

  late StreamSubscription<SessionsState> _stateSubscription;

  final BehaviorSubject<SessionsState> _stateSubject =
      BehaviorSubject<SessionsState>.seeded(const SessionsState.loading());

  Stream<SessionsState> get state => _stateSubject;

  void dispose() {
    _stateSubscription.cancel();
    _stateSubject.close();
  }

  Stream<SessionsState> _getSessionsStream() =>
      _sessionRepository.activeSessions.map((List<td.Session> sessions) {
        return SessionsState(
          activeSession: _sessionTileMapper.mapToTileModel(
            sessions.firstWhere((td.Session session) => session.isCurrent),
          ),
          sessions: sessions
              .where((td.Session session) => !session.isCurrent)
              .map(_sessionTileMapper.mapToTileModel)
              .toList(),
        );
      });
}
