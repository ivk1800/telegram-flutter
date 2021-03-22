import 'package:core/core.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:jugger/jugger.dart' as j;

class SessionsViewModel extends BaseViewModel
    with DataLoadingHandlerMixin<StateData> {
  @j.inject
  SessionsViewModel(this.sessionRepository) {
    startLoading();
  }

  final ISessionRepository sessionRepository;

  Stream<StateData> get stateData => sessionRepository.activeSessions
      .map((List<td.Session> event) => StateData(event));

  @override
  Stream<StateData> onCreateDataStream() => sessionRepository.activeSessions
      .map((List<td.Session> event) => StateData(event));
}

class StateData {
  StateData(this.sessions);

  final List<td.Session> sessions;
}
