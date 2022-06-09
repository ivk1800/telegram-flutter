import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
import 'package:feature_sessions_impl/src/screen/sessions/session_tile_listener.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_view_model.dart';
import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_factory_delegate.dart';
import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_model.dart';
import 'package:feature_sessions_impl/src/sessions_feature_dependencies.dmg.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

@j.Component(
  modules: <Type>[
    SessionsFeatureDependenciesModule,
    SessionsScreenModule,
    TgAppBarModule,
  ],
)
abstract class ISessionsScreenComponent {
  SessionsViewModel getSessionsViewModel();

  TileFactory getTileFactory();

  IStringsProvider getStringsProvider();

  tg.TgAppBarFactory getTgAppBarFactory();
}

@j.module
abstract class SessionsScreenModule {
  @j.singleton
  @j.provides
  static TileFactory provideTileFactory(
    ISessionTileListener listener,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          SessionTileModel: SessionTileFactory(
            listener: listener,
          ),
        },
      );

  @j.singleton
  @j.provides
  static ISessionTileListener provideSessionTileListener(
    SessionsViewModel viewModel,
  ) =>
      SessionTileListener(
        viewModel: viewModel,
      );
}

@j.componentBuilder
abstract class ISessionsScreenComponentBuilder {
  ISessionsScreenComponentBuilder dependencies(
    SessionsFeatureDependencies dependencies,
  );

  ISessionsScreenComponent build();
}
