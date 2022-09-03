import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_sessions_impl/src/screen/sessions/session_tile_listener.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_screen_scope_delegate.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_view_model.dart';
import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_factory_delegate.dart';
import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_model.dart';
import 'package:feature_sessions_impl/src/sessions_feature_dependencies.dmg.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

import 'sessions_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    SessionsFeatureDependenciesModule,
    SessionsScreenModule,
    TgAppBarModule,
  ],
  builder: ISessionsScreenComponentBuilder,
)
@j.singleton
abstract class ISessionsScreenComponent
    implements ISessionsScreenScopeDelegate {}

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
