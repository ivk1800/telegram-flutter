import 'package:feature_sessions_impl/src/sessions_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'sessions_screen_component.dart';

@j.componentBuilder
abstract class ISessionsScreenComponentBuilder {
  ISessionsScreenComponentBuilder dependencies(
    SessionsFeatureDependencies dependencies,
  );

  ISessionsScreenComponent build();
}
