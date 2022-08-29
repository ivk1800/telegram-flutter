import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/scope/application_scope.dart';
import 'package:app/src/feature/feature_provider.dart';
import 'package:app/src/navigation/app_controller_router_impl.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:app/src/navigation/split_navigation_router.dart';
import 'package:app/src/tdlib/config_provider.dart';
import 'package:app/src/widget/block_interaction_manager.dart';
import 'package:app_controller/app_controller.dart';
import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:auth_manager_impl/auth_manager_impl.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:chat_manager_impl/chat_manager_impl.dart';
import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:contacts_manager_impl/contacts_manager_impl.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:error_transformer_td/error_transformer_td.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:td_client/td_client.dart';
import 'package:tg_logger_api/tg_logger_api.dart';
import 'package:tg_logger_impl/tg_logger_impl.dart';

@j.module
abstract class AppModule {
  @applicationScope
  @j.provides
  static ILogger provideLogger() => TgLoggerImpl();

  @applicationScope
  @j.provides
  static TdClient provideTdClient() {
    return TdClient();
  }

  @applicationScope
  @j.provides
  static OptionsManager provideOptionsManager(
    ITdFunctionExecutor functionExecutor,
  ) =>
      OptionsManager(
        functionExecutor: functionExecutor,
      );

  @applicationScope
  @j.provides
  static IContactsManager provideContactsManager(
    ITdFunctionExecutor functionExecutor,
  ) =>
      ContactsManager(
        functionExecutor: functionExecutor,
      );

  @applicationScope
  @j.provides
  static IConnectivityProvider provideConnectivityProvider() =>
      ConnectivityProviderImpl();

  @applicationScope
  @j.provides
  static IAppLifecycleStateProvider provideAppLifecycleStateProvider() =>
      AppLifecycleStateProviderImpl();

  @applicationScope
  @j.provides
  static SplitNavigationInfoProvider provideSplitNavigationInfoProvider() =>
      SplitNavigationInfoProvider(TgApp.splitViewNavigatorKey);

  @applicationScope
  @j.provides
  static DateFormatter provideDateFormatter() => DateFormatter();

  @applicationScope
  @j.provides
  static DateParser provideDateParser() => DateParser();

  @applicationScope
  @j.binds
  ITdConfigProvider bindTdConfigProvider(TdConfigProvider impl);

  @applicationScope
  @j.provides
  static ISplitNavigationDelegate provideSplitNavigationDelegate() =>
      SplitNavigationDelegateImpl(
        TgApp.splitViewNavigatorKey,
      );

  @applicationScope
  @j.provides
  static IStringsProvider provideStringsProvider(
    ILocalizationManager localizationManager,
  ) =>
      localizationManager.stringsProvider;

  @applicationScope
  @j.binds
  IBlockInteractionManager bindBlockInteractionManager(
    BlockInteractionManager impl,
  );

  @applicationScope
  @j.provides
  static IErrorTransformer provideErrorTransformer() => TdErrorTransformer();

  @applicationScope
  @j.provides
  static IFileDownloader provideFileDownloader(
    FeatureProvider featureProvider,
  ) =>
      featureProvider.fileFeatureApi.fileDownloader;

  // region component

  @applicationScope
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

  @applicationScope
  @j.provides
  static IAuthenticationManager provideAuthenticationManager(
    ITdFunctionExecutor functionExecutor,
    IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider,
  ) =>
      AuthenticationManager(
        functionExecutor: functionExecutor,
        authenticationStateUpdatesProvider: authenticationStateUpdatesProvider,
      );

  @applicationScope
  @j.provides
  static IAppControllerRouter provideAppControllerRouter(
    FeatureProvider featureProvider,
  ) =>
      AppControllerRouterImpl(
        navigationKey: TgApp.splitViewNavigatorKey,
        authScreenFactory: featureProvider.authFeatureApi.authScreenFactory,
        mainScreenFactory:
            featureProvider.mainScreenFeatureApi.mainScreenFactory,
      );

  @applicationScope
  @j.provides
  static IChatManager provideChatManager(
    IChatRepository chatRepository,
    ITdFunctionExecutor functionExecutor,
  ) =>
      ChatManager(
        chatRepository: chatRepository,
        functionExecutor: functionExecutor,
      );

// endregion component
}
