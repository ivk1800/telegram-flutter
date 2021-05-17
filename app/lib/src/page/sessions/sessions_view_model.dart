import 'package:core/core.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class SessionsViewModel extends BaseViewModel
    with DataLoadingHandlerMixin<StateData> {
  @j.inject
  SessionsViewModel(this.sessionRepository) {
    startLoading();
  }

  final ISessionRepository sessionRepository;

  @override
  Stream<StateData> onCreateDataStream() => sessionRepository.activeSessions
      .map((List<td.Session> event) => StateData(
            thisSession:
                event.firstWhere((td.Session session) => session.isCurrent),
            // TODO: Ivan refactor filter sessions
            activeSessions: event
                .where((td.Session session) => !session.isCurrent)
                .toList(),
          ));
}

class StateData {
  StateData({required this.activeSessions, required this.thisSession});

  final td.Session thisSession;
  final List<td.Session> activeSessions;
}
