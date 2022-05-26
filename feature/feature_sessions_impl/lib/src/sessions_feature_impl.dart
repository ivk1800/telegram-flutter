import 'package:feature_sessions_api/feature_chat_api.dart';

import 'screen/sessions/sessions_screen_factory.dart';
import 'sessions_feature_dependencies.dart';

export 'screen/sessions/sessions_screen_router.dart';

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
