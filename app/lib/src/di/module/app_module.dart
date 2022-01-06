import 'package:app/app.dart';
import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/component/feature_component.jugger.dart';
import 'package:app/src/feature/feature.dart';
import 'package:app/src/navigation/app_controller_router_impl.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:app/src/navigation/split_navigation_router.dart';
import 'package:app/src/tdlib/config_provider.dart';
import 'package:app_controller/app_controller_component.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:core_utils/core_utils.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

@j.module
abstract class AppModule {
  @j.singleton
  @j.provides
  static FeatureFactory provideFeatureFactory() {
    return FeatureFactory(
      featureComponent:
          JuggerFeatureComponentBuilder().appComponent(appComponent).build(),
    );
  }

  @j.singleton
  @j.provides
  static TdClient provideTdClient() {
    return TdClient();
  }

  @j.singleton
  @j.provides
  static OptionsManager provideOptionsManager(
    ITdFunctionExecutor functionExecutor,
  ) =>
      OptionsManager(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  static IChatMessageRepository provideChatMessageRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      ChatMessageRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  static IChatRepository provideChatRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      ChatRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  static IFileRepository provideFileRepository(
    TdClient client,
  ) =>
      FileRepositoryImpl(
        client: client,
      );

  @j.singleton
  @j.provides
  static IUserRepository provideUserRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      UserRepositoryImpl(functionExecutor: functionExecutor);

  @j.singleton
  @j.provides
  static IStickerRepository provideStickerRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      StickerRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  static IBackgroundRepository provideBackgroundRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      BackgroundRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  static ISessionRepository provideSessionRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      SessionRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  @j.nonLazy
  static IChatFilterRepository provideChatFilterRepository(
    IChatFiltersUpdatesProvider chatFiltersUpdatesProvider,
  ) =>
      ChatFilterRepositoryImpl(
        chatFiltersUpdatesProvider: chatFiltersUpdatesProvider,
      );

  @j.singleton
  @j.provides
  static IBasicGroupRepository provideBasicGroupRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      BasicGroupRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  static ISuperGroupRepository provideSuperGroupRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      SuperGroupRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provides
  static IConnectivityProvider provideConnectivityProvider() =>
      ConnectivityProviderImpl();

  @j.singleton
  @j.provides
  static IAppLifecycleStateProvider provideAppLifecycleStateProvider() =>
      AppLifecycleStateProviderImpl();

  @j.singleton
  @j.provides
  static SplitNavigationInfoProvider provideSplitNavigationInfoProvider() =>
      SplitNavigationInfoProvider(TgApp.splitViewNavigatorKey);

  @j.singleton
  @j.provides
  static DateFormatter provideDateFormatter() => DateFormatter();

  @j.singleton
  @j.provides
  static DateParser provideDateParser() => DateParser();

  @j.singleton
  @j.binds
  ITdConfigProvider bindTdConfigProvider(TdConfigProvider impl);

  @j.singleton
  @j.provides
  static ISplitNavigationDelegate provideSplitNavigationDelegate(
    FeatureFactory featureFactory,
  ) =>
      SplitNavigationDelegateImpl(
        TgApp.splitViewNavigatorKey,
      );

  @j.singleton
  @j.provides
  static IAppController provideAppController(
    ITdConfigProvider tdConfigProvider,
    IAppLifecycleStateProvider appLifecycleStateProvider,
    IConnectivityProvider connectivityProvider,
    OptionsManager optionsManager,
    ITdFunctionExecutor functionExecutor,
    IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider,
    IAppControllerRouter router,
  ) =>
      AppControllerComponent(
        dependencies: AppControllerComponentDependencies(
          router: router,
          authenticationStateUpdatesProvider:
              authenticationStateUpdatesProvider,
          functionExecutor: functionExecutor,
          appLifecycleStateProvider: appLifecycleStateProvider,
          connectivityProvider: connectivityProvider,
          optionsManager: optionsManager,
          tdConfigProvider: tdConfigProvider,
        ),
      ).appController;

  @j.singleton
  @j.provides
  static IAppControllerRouter provideAppControllerRouter(
    FeatureFactory featureFactory,
  ) =>
      AppControllerRouterImpl(
        TgApp.splitViewNavigatorKey,
        featureFactory,
      );
}
