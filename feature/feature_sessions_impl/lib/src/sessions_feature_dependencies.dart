import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

import 'screen/sessions/sessions_screen_router.dart';

class SessionsFeatureDependencies {
  SessionsFeatureDependencies({
    required this.stringsProvider,
    required this.sessionRepository,
    required this.router,
    required this.connectionStateProvider,
  });

  final IStringsProvider stringsProvider;
  final ISessionsScreenRouter router;
  final ISessionRepository sessionRepository;
  final IConnectionStateProvider connectionStateProvider;
}
