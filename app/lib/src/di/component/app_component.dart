import 'package:app/src/di/module/app_module.dart';
import 'package:app/src/di/module/td_module.dart';
import 'package:app/src/feature/feature_provider.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:app/src/widget/block_interaction_manager.dart';
import 'package:app_controller/app_controller_component.dart';
import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:td_client/td_client.dart';

@j.Component(modules: <Type>[
  AppModule,
  TdModule,
])
abstract class IAppComponent {
  // region component

  IAppController getAppController();

  IAuthenticationManager getAuthenticationManager();

  // endregion component

  ITdConfigProvider getTdConfigProvider();

  TdClient getTdClient();

  IBasicGroupRepository getBasicGroupRepository();

  ISuperGroupRepository getSuperGroupRepository();

  IChatRepository getChatRepository();

  IStickerRepository getStickerRepository();

  IUserRepository getUserRepository();

  ISessionRepository getSessionRepository();

  IFileRepository getIFileRepository();

  IChatFilterRepository getChatFilterRepository();

  IChatMessageRepository getChatMessageRepository();

  IBackgroundRepository getBackgroundRepository();

  ISplitNavigationDelegate getSplitNavigationDelegate();

  SplitNavigationInfoProvider getSplitNavigationInfoProvider();

  DateFormatter getDateFormatter();

  DateParser getDateParser();

  IChatUpdatesProvider getChatUpdatesProvider();

  IChatMessagesUpdatesProvider getChatMessagesUpdatesProvider();

  IChatFiltersUpdatesProvider getChatFiltersUpdatesProvider();

  IFileUpdatesProvider getFileUpdatesProvider();

  ISuperGroupUpdatesProvider getSuperGroupUpdatesProvider();

  IBasicGroupUpdatesProvider getBasicGroupUpdatesProvider();

  IAuthenticationStateUpdatesProvider getAuthenticationStateUpdatesProvider();

  IConnectionStateProvider getConnectionStateProvider();

  IConnectivityProvider getConnectivityProvider();

  IAppLifecycleStateProvider getIAppLifecycleStateProvider();

  FeatureProvider getFeatureProvider();

  ILocalizationManager getLocalizationManager();

  IStringsProvider getStringsProvider();

  ITdFunctionExecutor getTdFunctionExecutor();

  IBlockInteractionManager getBlockInteractionManager();

  BlockInteractionManager getBlockInteractionManagerImpl();
}

@j.componentBuilder
abstract class IAppComponentBuilder {
  IAppComponentBuilder localizationManager(
    ILocalizationManager localizationManager,
  );

  IAppComponent build();
}
