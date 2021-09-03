import 'package:app/src/app/tg_app.dart';
import 'package:app/src/feature/feature.dart';
import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:app/src/navigation/dev_router_impl.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/notifications_settings_screen_router_impl.dart';
import 'package:app/src/navigation/stickers_feature_router.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
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
import 'package:feature_message_preview_resolver_impl/feature_message_preview_resolver_impl.dart';
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

  @j.provide
  static MainScreenFeatureDependencies provideMainScreenFeatureDependencies(
    ILocalizationManager localizationManager,
    IMainScreenRouter router,
    // todo do not depend on feature
    IGlobalSearchFeatureApi globalSearchFeatureApi,
    // todo do not depend on feature
    IChatsListFeatureApi chatsListFeatureApi,
    IConnectionStateProvider connectionStateProvider,
  ) =>
      MainScreenFeatureDependencies(
        localizationManager: localizationManager,
        router: router,
        connectionStateProvider: connectionStateProvider,
        chatsListFeatureApi: chatsListFeatureApi,
        globalSearchFeatureApi: globalSearchFeatureApi,
      );

  @j.provide
  static ChatsListFeatureDependencies provideChatsListFeatureDependencies(
    IChatRepository chatRepository,
    IFileRepository fileRepository,
    IChatsListScreenRouter router,
    DateFormatter dateFormatter,
    DateParser dateParser,
    IChatUpdatesProvider chatUpdatesProvider,
    IUserRepository userRepository,
    ILocalizationManager localizationManager,
    IChatMessageRepository chatMessageRepository,
  ) =>
      ChatsListFeatureDependencies(
          router: router,
          localizationManager: localizationManager,
          userRepository: userRepository,
          dateParser: dateParser,
          dateFormatter: dateFormatter,
          chatUpdatesProvider: chatUpdatesProvider,
          chatRepository: chatRepository,
          fileRepository: fileRepository,
          messagePreviewResolver: MessagePreviewResolver(
            messageRepository: chatMessageRepository,
            chatRepository: chatRepository,
            mode: Mode.ChatPreview,
            userRepository: userRepository,
            localizationManager: localizationManager,
          ));

  @j.provide
  static GlobalSearchFeatureDependencies
      provideGlobalSearchFeatureDependencies() =>
          const GlobalSearchFeatureDependencies();

  @j.provide
  static ChatFeatureDependencies provideChatFeatureDependencies(
    ILocalizationManager localizationManager,
    DateParser dateParser,
    IFileRepository fileRepository,
    IUserRepository userRepository,
    IChatScreenRouter router,
    IChatMessageRepository chatMessageRepository,
    IConnectionStateProvider connectionStateProvider,
    IChatRepository chatRepository,
    FeatureFactory featureFactory,
    DateFormatter dateFormatter,
    IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
  ) =>
      ChatFeatureDependencies(
        dateFormatter: dateFormatter,
        // todo move to app component global scope
        fileDownloader: featureFactory.createFileFeatureApi().fileDownloader,
        chatHeaderInfoFeatureApi: chatHeaderInfoFeatureApi,
        chatRepository: chatRepository,
        messagePreviewResolver: MessagePreviewResolver(
          messageRepository: chatMessageRepository,
          mode: Mode.ReplyPreview,
          chatRepository: chatRepository,
          userRepository: userRepository,
          localizationManager: localizationManager,
        ),
        connectionStateProvider: connectionStateProvider,
        chatMessageRepository: chatMessageRepository,
        router: router,
        localizationManager: localizationManager,
        dateParser: dateParser,
        fileRepository: fileRepository,
        userRepository: userRepository,
      );

  @j.provide
  static SettingsFeatureDependencies provideSettingsFeatureDependencies(
    ILocalizationManager localizationManager,
    ISettingsScreenRouter router,
    IConnectionStateProvider connectionStateProvider,
    // todo do not depend on feature
    ISettingsSearchFeatureApi settingsSearchFeatureApi,
  ) =>
      SettingsFeatureDependencies(
        localizationManager: localizationManager,
        router: router,
        connectionStateProvider: connectionStateProvider,
        settingsSearchFeatureApi: settingsSearchFeatureApi,
      );

  @j.provide
  static SettingsSearchFeatureDependencies
      provideSettingsSearchFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ISettingsSearchScreenRouter router,
    ILocalizationManager localizationManager,
  ) =>
          SettingsSearchFeatureDependencies(
            connectionStateProvider: connectionStateProvider,
            router: router,
            localizationManager: localizationManager,
          );

  @j.provide
  static PrivacySettingsFeatureDependencies
      providePrivacySettingsFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    IPrivacySettingsScreenRouter router,
    ILocalizationManager localizationManager,
  ) =>
          PrivacySettingsFeatureDependencies(
            connectionStateProvider: connectionStateProvider,
            router: router,
            localizationManager: localizationManager,
          );

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

  @j.provide
  static DataSettingsFeatureDependencies provideDataSettingsFeatureDependencies(
    ILocalizationManager localizationManager,
    IDataSettingsScreenRouter router,
    IConnectionStateProvider connectionStateProvider,
  ) =>
      DataSettingsFeatureDependencies(
        localizationManager: localizationManager,
        router: router,
        connectionStateProvider: connectionStateProvider,
      );

  @j.provide
  static ChatSettingsFeatureDependencies provideChatSettingsFeatureDependencies(
    ILocalizationManager localizationManager,
    IChatSettingsScreenRouter router,
    IConnectionStateProvider connectionStateProvider,
  ) =>
      ChatSettingsFeatureDependencies(
        localizationManager: localizationManager,
        router: router,
        connectionStateProvider: connectionStateProvider,
      );

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

  @j.provide
  static StickersFeatureDependencies provideStickersFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    IStickerRepository stickerRepository,
    IStickersFeatureRouter router,
  ) =>
      StickersFeatureDependencies(
        connectionStateProvider: connectionStateProvider,
        localizationManager: localizationManager,
        stickerRepository: stickerRepository,
        stickersFeatureRouter: router,
      );

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
    GlobalSearchFeatureDependencies dependencies,
  ) {
    return GlobalSearchFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IMainScreenFeatureApi provideMainScreenFeatureApi(
    MainScreenFeatureDependencies dependencies,
  ) {
    return MainScreenFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IChatHeaderInfoFeatureApi provideChatHeaderInfoFeatureApi(
    ChatHeaderInfoFeatureDependencies dependencies,
  ) {
    return ChatHeaderInfoFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IChatFeatureApi provideChatFeatureApi(
    ChatFeatureDependencies dependencies,
  ) {
    return ChatFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static IChatsListFeatureApi provideChatsListFeatureApi(
    ChatsListFeatureDependencies dependencies,
  ) {
    return ChatsListFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static ISettingsFeatureApi provideSettingsFeatureApi(
    SettingsFeatureDependencies dependencies,
  ) {
    return SettingsFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static ISettingsSearchFeatureApi provideSettingsSearchFeatureApi(
    SettingsSearchFeatureDependencies dependencies,
  ) =>
      SettingsSearchFeatureApi(dependencies: dependencies);

  @j.provide
  static IPrivacySettingsFeatureApi providePrivacySettingsFeatureApi(
    PrivacySettingsFeatureDependencies dependencies,
  ) =>
      PrivacySettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static INotificationsSettingsFeatureApi
      provideNotificationsSettingsFeatureApi(
    NotificationsSettingsFeatureDependencies dependencies,
  ) =>
          NotificationsSettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static IDataSettingsFeatureApi provideDataSettingsFeatureApi(
    DataSettingsFeatureDependencies dependencies,
  ) =>
      DataSettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static IChatSettingsFeatureApi provideChatSettingsFeatureApi(
    ChatSettingsFeatureDependencies dependencies,
  ) =>
      ChatSettingsFeatureApi(dependencies: dependencies);

  @j.provide
  static IWallpapersFeatureApi providewallpapersFeatureApi(
    WallpapersFeatureDependencies dependencies,
  ) =>
      WallpapersFeatureApi(dependencies: dependencies);

  @j.provide
  static IStickersFeatureApi provideStickersFeatureApi(
    StickersFeatureDependencies dependencies,
  ) =>
      StickersFeatureApi(dependencies: dependencies);

  @j.provide
  static IProfileFeatureApi provideProfileFeatureApi(
    ProfileFeatureDependencies dependencies,
  ) {
    return ProfileFeatureApi(dependencies: dependencies);
  }

  @j.provide
  static ISharedMediaFeatureApi provideSharedMediaFeatureApi(
    SharedMediaFeatureDependencies dependencies,
  ) =>
      SharedMediaFeatureApi(dependencies: dependencies);

  @j.provide
  static ICountryFeatureApi provideCountryFeatureApi(
    CountryFeatureDependencies dependencies,
  ) =>
      CountryFeatureApi(dependencies: dependencies);

  @j.provide
  static IAuthFeatureApi provideAuthFeatureApi(
    AuthFeatureDependencies dependencies,
  ) =>
      AuthFeatureApi(dependencies: dependencies);

  @j.provide
  static ILogoutFeatureApi provideLogoutFeatureApi(
    LogoutFeatureDependencies dependencies,
  ) =>
      LogoutFeatureApi(dependencies: dependencies);

  @j.provide
  static IFileFeatureApi provideFileFeatureApi(
    FileFeatureDependencies dependencies,
  ) =>
      FileFeatureApi(dependencies: dependencies);

  // endregion

  @j.provide
  static DevFeature provideDevFeature(
    IDevFeatureRouter router,
    TdClient client,
    IConnectionStateProvider connectionStateProvider,
  ) =>
      DevFeature(
        router: router,
        connectionStateProvider: connectionStateProvider,
        client: client,
      );

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
    ChatsListScreenRouterImpl impl,
  );

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
    SettingsSearchScreenRouterImpl impl,
  );

  @j.bind
  IPrivacySettingsScreenRouter bindPrivacySettingsScreenRouter(
    PrivacySettingsScreenRouterImpl impl,
  );

  @j.bind
  INotificationsSettingsScreenRouter bindNotificationsSettingsScreenRouter(
    NotificationsSettingsScreenRouterImpl impl,
  );

  @j.bind
  IDataSettingsScreenRouter bindDataSettingsScreenRouter(
    DataSettingsScreenRouterImpl impl,
  );

  @j.bind
  IChatSettingsScreenRouter bindChatSettingsScreenRouter(
    ChatSettingsScreenRouterImpl impl,
  );

  @j.bind
  IDevFeatureRouter bindDevFeatureRouter(DevScreenRouterImpl impl);

  @j.bind
  IWallpapersFeatureRouter bindwallpapersFeatureRouter(
    CommonScreenRouterImpl impl,
  );

  @j.bind
  IStickersFeatureRouter bindStickersFeatureRouter(
    StickersFeatureRouterImpl impl,
  );

  @j.bind
  IAuthFeatureRouter bindAuthFeatureRouter(CommonScreenRouterImpl impl);

  @j.bind
  ILogoutFeatureRouter bindLogoutFeatureRouter(CommonScreenRouterImpl impl);
// endregion
}
