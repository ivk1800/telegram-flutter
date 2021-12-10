import 'package:app/app.dart';
import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/component/feature_component.jugger.dart';
import 'package:app/src/feature/feature.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/tdlib/config_provider.dart';
import 'package:app/src/util/util.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:core_utils/core_utils.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

@j.module
abstract class AppModule {
  @j.singleton
  @j.provide
  static FeatureFactory provideFeatureFactory() {
    return FeatureFactory(
      featureComponent:
          JuggerFeatureComponentBuilder().appComponent(appComponent).build(),
    );
  }

  @j.singleton
  @j.provide
  static TdClient provideTdClient() {
    return TdClient();
  }

  @j.singleton
  @j.provide
  static OptionsManager provideOptionsManager(TdClient client) =>
      OptionsManager(client);

  @j.singleton
  @j.provide
  static IChatMessageRepository provideChatMessageRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      ChatMessageRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provide
  static IChatRepository provideChatRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      ChatRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provide
  static IFileRepository provideFileRepository(
    TdClient client,
  ) =>
      FileRepositoryImpl(
        client: client,
      );

  @j.singleton
  @j.provide
  static IUserRepository provideUserRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      UserRepositoryImpl(functionExecutor: functionExecutor);

  @j.singleton
  @j.provide
  static IStickerRepository provideStickerRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      StickerRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provide
  static IBackgroundRepository provideBackgroundRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      BackgroundRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provide
  static ISessionRepository provideSessionRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      SessionRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provide
  static IChatFilterRepository provideChatFilterRepository(
    IChatFiltersUpdatesProvider chatFiltersUpdatesProvider,
  ) =>
      ChatFilterRepositoryImpl(
        chatFiltersUpdatesProvider: chatFiltersUpdatesProvider,
      );

  @j.singleton
  @j.provide
  static IBasicGroupRepository provideBasicGroupRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      BasicGroupRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.provide
  static ISuperGroupRepository provideSuperGroupRepository(
    ITdFunctionExecutor functionExecutor,
  ) =>
      SuperGroupRepositoryImpl(
        functionExecutor: functionExecutor,
      );

  @j.singleton
  @j.bind
  IConnectivityProvider bindConnectivityProvider(ConnectivityProviderImpl impl);

  @j.singleton
  @j.bind
  IAppLifecycleStateProvider bindAppLifecycleStateProvider(
    AppLifecycleStateProviderImpl impl,
  );

  @j.singleton
  @j.provide
  static SplitNavigationInfoProvider provideSplitNavigationInfoProvider() =>
      SplitNavigationInfoProvider(TgApp.splitViewNavigatorKey);

  @j.singleton
  @j.provide
  static SplitNavigationRouter provideSplitViewNavigationRouter(
    FeatureFactory featureFactory,
  ) =>
      SplitNavigationRouter(TgApp.splitViewNavigatorKey, featureFactory);

  @j.singleton
  @j.provide
  static INavigationRouter provideRootNavigationRouter(
    SplitNavigationRouter splitViewNavigationRouter,
  ) =>
      splitViewNavigationRouter;

  @j.singleton
  @j.provide
  static DateFormatter provideDateFormatter() => DateFormatter();

  @j.singleton
  @j.provide
  static DateParser provideDateParser() => DateParser();

  @j.singleton
  @j.provide
  static IStringsProvider provideStringsProvider() => DefaultStringProvider();

  @j.singleton
  @j.provide
  static TdConfigProvider provideTdConfigProvider() => TdConfigProvider();
}
