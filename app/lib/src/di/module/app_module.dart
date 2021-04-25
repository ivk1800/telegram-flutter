import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/presentation.dart';
import 'package:presentation/src/app/app.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:presentation/src/util/util.dart';
import 'package:td_client/td_client.dart';

@j.module
abstract class AppModule {
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
  static INavigationRouter provideRootNavigationRouter() =>
      RootNavigationRouter(MyApp.navigatorKey);

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
