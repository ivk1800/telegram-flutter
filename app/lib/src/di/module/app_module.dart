import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/presentation.dart';
import 'package:presentation/src/app/app.dart';
import 'package:presentation/src/di/component/feature_component.jugger.dart';
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:presentation/src/navigation/split_navigation_router.dart';
import 'package:presentation/src/util/util.dart';
import 'package:td_client/td_client.dart';

@j.module
abstract class AppModule {
  @j.singleton
  @j.provide
  static FeatureFactory provideFeatureFactory() {
    return FeatureFactory(
        featureComponent:
            JuggerFeatureComponentBuilder().appComponent(appComponent).build());
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
  @j.bind
  IChatMessageRepository bindChatMessageRepository(
      ChatMessageRepositoryImpl impl);

  @j.singleton
  @j.bind
  IChatRepository bindChatRepository(ChatRepositoryImpl impl);

  @j.singleton
  @j.bind
  IFileRepository bindFileRepository(FileRepositoryImpl impl);

  @j.singleton
  @j.bind
  ISessionRepository bindSessionRepository(SessionRepositoryImpl impl);

  @j.singleton
  @j.bind
  IChatFilterRepository bindChatFilterRepository(ChatFilterRepositoryImpl impl);

  @j.singleton
  @j.bind
  IConnectivityProvider bindConnectivityProvider(ConnectivityProviderImpl impl);

  @j.singleton
  @j.bind
  IAppLifecycleStateProvider bindAppLifecycleStateProvider(
      AppLifecycleStateProviderImpl impl);

  @j.singleton
  @j.provide
  static RootNavigationRouter provideNavigationRouter(
          FeatureFactory featureFactory) =>
      RootNavigationRouter(MyApp.navigatorKey, featureFactory);

  @j.singleton
  @j.provide
  static SplitNavigationInfoProvider provideSplitNavigationInfoProvider() =>
      SplitNavigationInfoProvider(MyApp.splitViewNavigatorKey);

  @j.singleton
  @j.provide
  static SplitNavigationRouter provideSplitViewNavigationRouter(
          FeatureFactory featureFactory) =>
      SplitNavigationRouter(MyApp.splitViewNavigatorKey, featureFactory);

  @j.singleton
  @j.provide
  static INavigationRouter provideRootNavigationRouter(
          SplitNavigationRouter splitViewNavigationRouter) =>
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
}
