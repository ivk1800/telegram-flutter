import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
import 'package:feature_sessions_impl/src/screen/sessions/session_tile_listener.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_interactor.dart';
import 'package:feature_sessions_impl/src/screen/sessions/sessions_view_model.dart';
import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_factory_delegate.dart';
import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

@j.Component(
  modules: <Type>[SessionsScreenModule],
)
abstract class ISessionsScreenComponent {
  SessionsViewModel getSessionsViewModel();

  TileFactory getTileFactory();

  ILocalizationManager getLocalizationManager();

  tg.TgAppBarFactory getTgAppBarFactory();
}

@j.module
abstract class SessionsScreenModule {
  @j.singleton
  @j.provides
  static SessionsViewModel provideSessionsViewModel(
    SessionsFeatureDependencies dependencies,
    SessionsInteractor sessionsInteractor,
  ) =>
      SessionsViewModel(
        router: dependencies.router,
        sessionsInteractor: sessionsInteractor,
      )..init();

  @j.singleton
  @j.provides
  static ISessionRepository provideSessionRepository(
    SessionsFeatureDependencies dependencies,
  ) =>
      dependencies.sessionRepository;

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
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    SessionsFeatureDependencies dependencies,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: dependencies.connectionStateProvider,
      );

  @j.singleton
  @j.provides
  static tg.TgAppBarFactory provideTgAppBarFactory(
    tg.ConnectionStateWidgetFactory connectionStateWidgetFactory,
  ) =>
      tg.TgAppBarFactory(
        connectionStateWidgetFactory: connectionStateWidgetFactory,
      );

  @j.singleton
  @j.provides
  static ILocalizationManager provideLocalizationManager(
    SessionsFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

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
