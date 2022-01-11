library feature_sessions_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_sessions_api/feature_chat_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/sessions/sessions_screen_factory.dart';
import 'src/screen/sessions/sessions_screen_router.dart';

export 'src/screen/sessions/sessions_screen_router.dart';

class SessionsFeatureImpl implements ISessionsFeatureApi {
  SessionsFeatureImpl({
    required SessionsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SessionsFeatureDependencies _dependencies;

  late final SessionsScreenFactory _sessionsScreenFactory =
      SessionsScreenFactory(
    dependencies: _dependencies,
  );

  @override
  ISessionsScreenFactory get sessionsScreenFactory => _sessionsScreenFactory;
}

class SessionsFeatureDependencies {
  SessionsFeatureDependencies({
    required this.localizationManager,
    required this.sessionRepository,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;
  final ISessionsScreenRouter router;
  final ISessionRepository sessionRepository;
  final IConnectionStateProvider connectionStateProvider;
}
