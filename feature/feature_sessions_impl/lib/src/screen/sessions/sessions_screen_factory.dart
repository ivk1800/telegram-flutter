import 'package:feature_sessions_api/feature_chat_api.dart';
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
import 'package:feature_sessions_impl/src/di/sessions_screen_component.jugger.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_page.dart';
import 'package:flutter/widgets.dart';

import 'sessions_screen_scope_delegate.scope.dart';

class SessionsScreenFactory implements ISessionsScreenFactory {
  SessionsScreenFactory({
    required SessionsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SessionsFeatureDependencies _dependencies;

  @override
  Widget create() {
    return SessionsScreenScope(
      child: const SessionsPage(),
      create: () => JuggerSessionsScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
