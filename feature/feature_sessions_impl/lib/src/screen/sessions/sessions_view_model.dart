import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_interactor.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_state.dart';
import 'package:jugger/jugger.dart' as j;

@j.singleton
@j.disposable
class SessionsViewModel extends BaseViewModel {
  @j.inject
  SessionsViewModel({
    required SessionsInteractor sessionsInteractor,
    required ISessionsScreenRouter router,
  })  : _router = router,
        _sessionsInteractor = sessionsInteractor;

  final ISessionsScreenRouter _router;
  final SessionsInteractor _sessionsInteractor;

  Stream<SessionsState> get state => _sessionsInteractor.state;

  void onSessionTap(int id) {
    _router.toNotImplemented();
  }

  void onTerminatedSessionsTap() {
    _router.toNotImplemented();
  }

  void onScanQRCodeTap() {
    _router.toNotImplemented();
  }

  @override
  void dispose() {
    _sessionsInteractor.dispose();
    super.dispose();
  }
}
