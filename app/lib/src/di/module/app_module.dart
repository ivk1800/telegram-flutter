import 'package:app/app.dart';
import 'package:app/src/app/app_delegate.dart';
import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/component/feature_component.jugger.dart';
import 'package:app/src/feature/feature.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/tdlib/config_provider.dart';
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
  static OptionsManager provideOptionsManager(TdClient client) =>
      OptionsManager(client);

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
  @j.binds
  IConnectivityProvider bindConnectivityProvider(ConnectivityProviderImpl impl);

  @j.singleton
  @j.binds
  IAppLifecycleStateProvider bindAppLifecycleStateProvider(
    AppLifecycleStateProviderImpl impl,
  );

  @j.singleton
  @j.provides
  static SplitNavigationInfoProvider provideSplitNavigationInfoProvider() =>
      SplitNavigationInfoProvider(TgApp.splitViewNavigatorKey);

  @j.singleton
  @j.provides
  static SplitNavigationRouter provideSplitViewNavigationRouter(
    FeatureFactory featureFactory,
  ) =>
      SplitNavigationRouter(TgApp.splitViewNavigatorKey, featureFactory);

  @j.singleton
  @j.binds
  INavigationRouter bindRootNavigationRouter(SplitNavigationRouter impl);

  @j.singleton
  @j.provides
  static DateFormatter provideDateFormatter() => DateFormatter();

  @j.singleton
  @j.provides
  static DateParser provideDateParser() => DateParser();

  @j.singleton
  @j.provides
  static TdConfigProvider provideTdConfigProvider() => TdConfigProvider();

  @j.singleton
  @j.provides
  static AppDelegate provideAppDelegate(
    TdClient client,
    INavigationRouter router,
    TdConfigProvider tdConfigProvider,
    IAppLifecycleStateProvider appLifecycleStateProvider,
    IConnectivityProvider connectivityProvider,
    OptionsManager optionsManager,
  ) =>
      AppDelegate(
          router: router,
          client: client,
          appLifecycleStateProvider: appLifecycleStateProvider,
          connectivityProvider: connectivityProvider,
          optionsManager: optionsManager,
          tdConfigProvider: tdConfigProvider);
}
