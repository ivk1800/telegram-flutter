import 'package:app/src/app/tg_app.dart';
import 'package:app/src/di/component/app_component.dart';
import 'package:app/src/di/component/feature_component.jugger.dart';
import 'package:app/src/feature/feature.dart';
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
import 'package:core_tdlib_impl/core_tdlib_impl.dart';
import 'package:core_utils/core_utils.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:error_transformer_td/error_transformer_td.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:td_client/td_client.dart';
import 'package:tg_logger_api/tg_logger_api.dart';
import 'package:tg_logger_impl/tg_logger_impl.dart';

@j.module
abstract class AppModule {
  @j.singleton
  @j.provides
  static ILogger provideLogger() => TgLoggerImpl();

  @j.singleton
  @j.provides
  static FeatureFactory provideFeatureFactory(IAppComponent appComponent) {
    return FeatureFactory(
      featureComponent:
          JuggerFeatureComponentBuilder().appComponent(appComponent).build(),
    );
  }

  @j.singleton
  @j.provides
  static FeatureProvider provideFeatureProvider(
    FeatureFactory featureFactory,
  ) {
    return FeatureProvider(
      featureFactory: featureFactory,
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
  static IContactsManager provideContactsManager(
    ITdFunctionExecutor functionExecutor,
  ) =>
      ContactsManager(
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
    IUserUpdatesProvider userUpdatesProvider,
  ) =>
      UserRepositoryImpl(
        userUpdatesProvider: userUpdatesProvider,
        functionExecutor: functionExecutor,
      );

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
  static ISplitNavigationDelegate provideSplitNavigationDelegate() =>
      SplitNavigationDelegateImpl(
        TgApp.splitViewNavigatorKey,
      );

  @j.singleton
  @j.provides
  static IStringsProvider provideStringsProvider(
    ILocalizationManager localizationManager,
  ) =>
      localizationManager.stringsProvider;

  @j.singleton
  @j.binds
  IBlockInteractionManager bindBlockInteractionManager(
    BlockInteractionManager impl,
  );

  @j.singleton
  @j.provides
  static IErrorTransformer provideErrorTransformer() => TdErrorTransformer();

  // region component

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
  static IAuthenticationManager provideAuthenticationManager(
    ITdFunctionExecutor functionExecutor,
    IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider,
  ) =>
      AuthenticationManager(
        functionExecutor: functionExecutor,
        authenticationStateUpdatesProvider: authenticationStateUpdatesProvider,
      );

  @j.singleton
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

  @j.singleton
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
