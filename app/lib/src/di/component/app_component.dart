import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/module/app_module.dart';
import 'package:presentation/src/di/module/td_module.dart';
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:presentation/src/page/page.dart';
import 'package:presentation/src/util/util.dart';
import 'package:td_client/td_client.dart';

@j.Component(modules: <Type>[
  AppModule,
  TdModule,
])
abstract class AppComponent {
  TdClient getTdClient();

  IChatRepository getChatRepository();

  ISessionRepository getSessionRepository();

  IFileRepository getIFileRepository();

  IChatFilterRepository getChatFilterRepository();

  IChatMessageRepository getChatMessageRepository();

  INavigationRouter getNavigationRouter();

  RootNavigationRouter getRootNavigationRouter();

  IStringsProvider getStringsProvider();

  DateFormatter getDateFormatter();

  DateParser getDateParser();

  IChatUpdatesProvider getChatUpdatesProvider();

  IChatFiltersUpdatesProvider getChatFiltersUpdatesProvider();

  IConnectionStateUpdatesProvider getConnectionStateUpdatesProvider();

  IConnectivityProvider getConnectivityProvider();

  IAppLifecycleStateProvider getIAppLifecycleStateProvider();

  FeatureFactory getFeatureFactory();

  void injectRootPageState(RootPageState state);
}

@j.componentBuilder
abstract class AppComponentBuilder {
  AppComponent build();
}
