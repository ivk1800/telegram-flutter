import 'package:core_arch/core_arch.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_sessions_api/feature_chat_api.dart';
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
import 'package:feature_sessions_impl/src/di/sessions_screen_component.dart';
import 'package:feature_sessions_impl/src/di/sessions_screen_component.jugger.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_page.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:tile/tile.dart';

class SessionsScreenFactory implements ISessionsScreenFactory {
  SessionsScreenFactory({
    required SessionsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SessionsFeatureDependencies _dependencies;

  @override
  Widget create() {
    return Scope<SessionsScreenComponent>(
      create: () => JuggerSessionsScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
      providers: (SessionsScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<SessionsViewModel>(
            create: (BuildContext _) => component.getSessionsViewModel(),
          ),
          Provider<TileFactory>(
            create: (BuildContext _) => component.getTileFactory(),
          ),
          Provider<ILocalizationManager>(
            create: (BuildContext _) => component.getLocalizationManager(),
          ),
          Provider<tg.TgAppBarFactory>(
            create: (BuildContext _) => component.getTgAppBarFactory(),
          ),
        ];
      },
      child: const SessionsPage(),
    );
  }
}
