import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:presentation/src/di/module/app_module.dart';
import 'package:presentation/src/di/module/td_module.dart';
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:presentation/src/navigation/split_navigation_router.dart';
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

  IStickerRepository getStickerRepository();

  ISessionRepository getSessionRepository();

  IFileRepository getIFileRepository();

  IChatFilterRepository getChatFilterRepository();

  IChatMessageRepository getChatMessageRepository();

  IBackgroundRepository getBackgroundRepository();

  INavigationRouter getNavigationRouter();

  RootNavigationRouter getRootNavigationRouter();

  SplitNavigationRouter getSplitNavigationRouter();

  SplitNavigationInfoProvider getSplitNavigationInfoProvider();

  IStringsProvider getStringsProvider();

  DateFormatter getDateFormatter();

  DateParser getDateParser();

  IChatUpdatesProvider getChatUpdatesProvider();

  IChatFiltersUpdatesProvider getChatFiltersUpdatesProvider();

  IConnectionStateProvider getConnectionStateProvider();

  IConnectivityProvider getConnectivityProvider();

  IAppLifecycleStateProvider getIAppLifecycleStateProvider();

  FeatureFactory getFeatureFactory();

  ILocalizationManager getLocalizationManager();

  void injectRootPageState(RootPageState state);
}

@j.componentBuilder
abstract class AppComponentBuilder {
  AppComponentBuilder localizationManager(
      ILocalizationManager localizationManager);

  AppComponent build();
}
