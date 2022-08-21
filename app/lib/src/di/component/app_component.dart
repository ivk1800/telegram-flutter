import 'package:app/src/di/module/app_module.dart';
import 'package:app/src/di/module/app_navigation_module.dart';
import 'package:app/src/di/module/data_module.dart';
import 'package:app/src/di/module/td_module.dart';
import 'package:app/src/di/module/theme_module.dart';
import 'package:app/src/di/scope/application_scope.dart';
import 'package:app/src/feature/feature_provider.dart';
import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:app/src/widget/block_interaction_manager.dart';
import 'package:app_controller/app_controller.dart';
import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:td_client/td_client.dart';
import 'package:tg_logger_api/tg_logger_api.dart';
import 'package:theme_manager_flutter/theme_manager_flutter.dart';

import 'app_component_builder.dart';

@j.Component(
  modules: <Type>[
    AppModule,
    DataModule,
    TdModule,
    ThemeModule,
    AppNavigationModule,
  ],
  builder: IAppComponentBuilder,
)
@applicationScope
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

  IEventsProvider getEventsProvider();

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

  IErrorTransformer getErrorTransformer();

  IContactsManager getContactsManager();

  OptionsManager getOptionsManager();

  // region theme

  IThemeManager getThemeManager();

  ThemeManager getThemeManagerImpl();

  ThemeDataResolver getThemeDataResolver();

  // endregion theme

  MyChatProvider get myChatProvider;

  IChatManager get chatManager;

  ILogger get logger;

  IFileDownloader get fileDownloader;

  CommonScreenRouterImpl get commonScreenRouter;
}
