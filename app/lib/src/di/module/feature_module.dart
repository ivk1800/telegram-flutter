import 'package:app/src/app/tg_app.dart';
import 'package:app/src/feature/chat_feature_dependencies.dart';
import 'package:app/src/feature/feature.dart';
import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:app/src/navigation/dev_router_impl.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/notifications_settings_screen_router_impl.dart';
import 'package:app/src/navigation/stickers_feature_router.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_header_info_impl/feature_chat_header_info_impl.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/feature_country_impl.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_file_impl/feature_file_impl.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:feature_logout_impl/feature_logout_impl.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_privacy_settings_impl/feature_privacy_settings_impl.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_shared_media_impl/feature_shared_media_impl.dart';
import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_wallpapers_api/feature_wallpapers_api.dart';
import 'package:feature_wallpapers_impl/feature_wallpapers_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:td_client/td_client.dart';

@j.module
abstract class FeatureModule {
  // region dependencies

  @j.bind
  IMainScreenFeatureDependencies bindMainScreenFeatureDependencies(
      MainScreenFeatureDependencies impl);

  @j.bind
  IChatsListFeatureDependencies bindChatsListFeatureDependencies(
      ChatsListFeatureDependencies impl);

  @j.bind
  IGlobalSearchFeatureDependencies bindGlobalSearchFeatureDependencies(
      GlobalSearchFeatureDependencies impl);

  @j.bind
  IChatFeatureDependencies bindChatFeatureDependencies(
      ChatFeatureDependencies impl);

  @j.bind
  ISettingsFeatureDependencies bindSettingsFeatureDependencies(
      SettingsFeatureDependencies impl);

  @j.bind
  ISettingsSearchFeatureDependencies bindSettingsSearchFeatureDependencies(
      SettingsSearchFeatureDependencies impl);

  @j.bind
  IPrivacySettingsFeatureDependencies bindPrivacySettingsFeatureDependencies(
      PrivacySettingsFeatureDependencies impl);

  @j.provide
  static NotificationsSettingsFeatureDependencies
      provideNotificationsSettingsFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    INotificationsSettingsScreenRouter router,
  ) =>
          NotificationsSettingsFeatureDependencies(
            connectionStateProvider: connectionStateProvider,
            localizationManager: localizationManager,
            router: router,
          );

  @j.bind
  IDataSettingsFeatureDependencies bindDataSettingsFeatureDependencies(
      DataSettingsFeatureDependencies impl);

  @j.bind
  IChatSettingsFeatureDependencies bindChatSettingsFeatureDependencies(
      ChatSettingsFeatureDependencies impl);

  @j.provide
  static WallpapersFeatureDependencies provideWallpapersFeatureDependencies(
    IBackgroundRepository backgroundRepository,
    FeatureFactory featureFactory,
    ILocalizationManager localizationManager,
    IWallpapersFeatureRouter router,
    IConnectionStateProvider connectionStateProvider,
  ) =>
      WallpapersFeatureDependencies(
        localizationManager: localizationManager,
        router: router,
        connectionStateProvider: connectionStateProvider,
        backgroundRepository: backgroundRepository,
        // todo move to app component global scope
        fileDownloader: featureFactory.createFileFeatureApi().fileDownloader,
      );

  @j.bind
  IStickersFeatureDependencies bindStickersFeatureDependencies(
      StickersFeatureDependencies impl);

  @j.provide
  static ChatHeaderInfoFeatureDependencies
      provideChatHeaderInfoFeatureDependencies(
    IChatRepository chatRepository,
    ILocalizationManager localizationManager,
    IBasicGroupRepository basicGroupRepository,
    ISuperGroupRepository superGroupRepository,
    IConnectionStateProvider connectionStateProvider,
    IFileRepository fileRepository,
    IUserRepository userRepository,
  ) {
    return ChatHeaderInfoFeatureDependencies(
      chatRepository: chatRepository,
      localizationManager: localizationManager,
      basicGroupRepository: basicGroupRepository,
      superGroupRepository: superGroupRepository,
      userRepository: userRepository,
      connectionStateProvider: connectionStateProvider,
      fileRepository: fileRepository,
    );
  }

  @j.provide
  static ProfileFeatureDependencies provideProfileFeatureDependencies(
    IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
    IUserRepository userRepository,
    ISuperGroupRepository superGroupRepository,
    IBasicGroupRepository basicGroupRepository,
    IChatMessageRepository messageRepository,
    IChatRepository chatRepository,
    IProfileFeatureRouter router,
    ILocalizationManager localizationManager,
  ) =>
      ProfileFeatureDependencies(
        router: router,
        localizationManager: localizationManager,
        chatRepository: chatRepository,
        messageRepository: messageRepository,
        userRepository: userRepository,
        superGroupRepository: superGroupRepository,
        basicGroupRepository: basicGroupRepository,
        chatHeaderInfoFeatureApi: chatHeaderInfoFeatureApi,
      );

  @j.provide
  static SharedMediaFeatureDependencies provideSharedMediaFeatureDependencies(
    IChatMessageRepository messageRepository,
  ) =>
      SharedMediaFeatureDependencies(
        messageRepository: messageRepository,
      );

  @j.provide
  static CountryFeatureDependencies provideCountryFeatureDependencies(
    ILocalizationManager localizationManager,
  ) =>
      CountryFeatureDependencies(
        localizationManager: localizationManager,
      );

  @j.provide
  static AuthFeatureDependencies provideAuthFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    IAuthFeatureRouter router,
    ITdFunctionExecutor functionExecutor,
    IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider,
    // todo maybe provide countryRepository from app component?
    // todo with singleton scope?
    FeatureFactory featureFactory,
  ) =>
      AuthFeatureDependencies(
        connectionStateProvider: connectionStateProvider,
        localizationManager: localizationManager,
        router: router,
        functionExecutor: functionExecutor,
        authenticationStateUpdatesProvider: authenticationStateUpdatesProvider,
        countryRepository:
            featureFactory.createCountryFeatureApi().countryRepository,
      );

  @j.provide
  static LogoutFeatureDependencies provideLogoutFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    ILogoutFeatureRouter router,
    ITdFunctionExecutor functionExecutor,
    // todo maybe provide authenticationManager from app component?
    // todo with singleton scope?
    FeatureFactory featureFactory,
  ) =>
      LogoutFeatureDependencies(
        connectionStateProvider: connectionStateProvider,
        localizationManager: localizationManager,
        router: router,
        authenticationManager:
            featureFactory.createAuthFeatureApi().authenticationManager,
      );

  @j.provide
  static FileFeatureDependencies provideFileFeatureDependencies(
    IFileRepository fileRepository,
    IFileUpdatesProvider fileUpdatesProvider,
    ITdFunctionExecutor functionExecutor,
  ) =>
      FileFeatureDependencies(
        fileRepository: fileRepository,
        fileUpdatesProvider: fileUpdatesProvider,
        functionExecutor: functionExecutor,
      );

  // endregion

  // region api

  @j.provide
  static IGlobalSearchFeatureApi provideGlobalSearchFeatureApi(
      IGlobalSearchFeatureDependencies dependencies) {
    return GlobalSearchFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IMainScreenFeatureApi provideMainScreenFeatureApi(
      IMainScreenFeatureDependencies dependencies) {
    return MainScreenFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IChatHeaderInfoFeatureApi provideChatHeaderInfoFeatureApi(
      ChatHeaderInfoFeatureDependencies dependencies) {
    return ChatHeaderInfoFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IChatFeatureApi provideChatFeatureApi(
      IChatFeatureDependencies dependencies) {
    return ChatFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IChatsListFeatureApi provideChatsListFeatureApi(
      IChatsListFeatureDependencies dependencies) {
    return ChatsListFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static ISettingsFeatureApi provideSettingsFeatureApi(
      ISettingsFeatureDependencies dependencies) {
    return SettingsFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static ISettingsSearchFeatureApi provideSettingsSearchFeatureApi(
          ISettingsSearchFeatureDependencies dependencies) =>
      SettingsSearchFeatureApi(dependencies: dependencies);

  @j.provide
  static IPrivacySettingsFeatureApi providePrivacySettingsFeatureApi(
          IPrivacySettingsFeatureDependencies dependencies) =>
      PrivacySettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static INotificationsSettingsFeatureApi
      provideNotificationsSettingsFeatureApi(
              NotificationsSettingsFeatureDependencies dependencies) =>
          NotificationsSettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static IDataSettingsFeatureApi provideDataSettingsFeatureApi(
          IDataSettingsFeatureDependencies dependencies) =>
      DataSettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static IChatSettingsFeatureApi provideChatSettingsFeatureApi(
          IChatSettingsFeatureDependencies dependencies) =>
      ChatSettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static IWallpapersFeatureApi providewallpapersFeatureApi(
          WallpapersFeatureDependencies dependencies) =>
      WallpapersFeatureApi(dependencies: dependencies);

  @j.provide
  static IStickersFeatureApi provideStickersFeatureApi(
          IStickersFeatureDependencies dependencies) =>
      StickersFeatureApi(dependencies: dependencies);

  @j.provide
  static IProfileFeatureApi provideProfileFeatureApi(
      ProfileFeatureDependencies dependencies) {
    return ProfileFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static ISharedMediaFeatureApi provideSharedMediaFeatureApi(
          SharedMediaFeatureDependencies dependencies) =>
      SharedMediaFeatureApi(dependencies: dependencies);

  @j.provide
  static ICountryFeatureApi provideCountryFeatureApi(
          CountryFeatureDependencies dependencies) =>
      CountryFeatureApi(dependencies: dependencies);

  @j.provide
  static IAuthFeatureApi provideAuthFeatureApi(
          AuthFeatureDependencies dependencies) =>
      AuthFeatureApi(dependencies: dependencies);

  @j.provide
  static ILogoutFeatureApi provideLogoutFeatureApi(
          LogoutFeatureDependencies dependencies) =>
      LogoutFeatureApi(dependencies: dependencies);

  @j.provide
  static IFileFeatureApi provideFileFeatureApi(
          FileFeatureDependencies dependencies) =>
      FileFeatureApi(dependencies: dependencies);

  // endregion

  @j.provide
  static DevFeature provideDevFeature(IDevFeatureRouter router, TdClient client,
          IConnectionStateProvider connectionStateProvider) =>
      DevFeature(
          router: router,
          connectionStateProvider: connectionStateProvider,
          client: client);

  // region router

  @j.provide
  @j.singleton
  static CommonScreenRouterImpl provideCommonScreenRouter(
    FeatureFactory featureFactory,
    SplitNavigationRouter splitNavigationRouter,
  ) =>
      CommonScreenRouterImpl(
        dialogNavigatorKey: TgApp.navigatorKey,
        featureFactory: featureFactory,
        navigationRouter: splitNavigationRouter,
      );

  @j.bind
  IChatsListScreenRouter bindChatsListScreenRouter(
      ChatsListScreenRouterImpl impl);

  @j.bind
  IMainScreenRouter bindMainScreenRouter(MainScreenRouterImpl impl);

  @j.bind
  IChatScreenRouter bindChatScreenRouter(CommonScreenRouterImpl impl);

  @j.bind
  IProfileFeatureRouter bindProfileFeatureRouter(CommonScreenRouterImpl impl);

  @j.bind
  ISettingsScreenRouter bindSettingsScreenRouter(SettingsScreenRouterImpl impl);

  @j.bind
  ISettingsSearchScreenRouter bindSettingsSearchScreenRouter(
      SettingsSearchScreenRouterImpl impl);

  @j.bind
  IPrivacySettingsScreenRouter bindPrivacySettingsScreenRouter(
      PrivacySettingsScreenRouterImpl impl);

  @j.bind
  INotificationsSettingsScreenRouter bindNotificationsSettingsScreenRouter(
      NotificationsSettingsScreenRouterImpl impl);

  @j.bind
  IDataSettingsScreenRouter bindDataSettingsScreenRouter(
      DataSettingsScreenRouterImpl impl);

  @j.bind
  IChatSettingsScreenRouter bindChatSettingsScreenRouter(
      ChatSettingsScreenRouterImpl impl);

  @j.bind
  IDevFeatureRouter bindDevFeatureRouter(DevScreenRouterImpl impl);

  @j.bind
  IWallpapersFeatureRouter bindwallpapersFeatureRouter(
      CommonScreenRouterImpl impl);

  @j.bind
  IStickersFeatureRouter bindStickersFeatureRouter(
      StickersFeatureRouterImpl impl);

  @j.bind
  IAuthFeatureRouter bindAuthFeatureRouter(CommonScreenRouterImpl impl);

  @j.bind
  ILogoutFeatureRouter bindLogoutFeatureRouter(CommonScreenRouterImpl impl);
// endregion
}
