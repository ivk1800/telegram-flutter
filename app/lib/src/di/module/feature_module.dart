import 'package:app/src/app/tg_app.dart';
import 'package:app/src/feature/feature_provider.dart';
import 'package:app/src/navigation/chat_router_delegate.dart';
import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:app/src/navigation/navigation.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:app/src/navigation/router/change_bio_router.dart';
import 'package:app/src/navigation/router/change_username_router.dart';
import 'package:app/src/navigation/router/chat_administration_router_factory.dart';
import 'package:app/src/navigation/router/create_new_chat_router_impl.dart';
import 'package:app/src/navigation/router/new_contact_router.dart';
import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_change_bio_api/feature_change_bio_api.dart';
import 'package:feature_change_bio_impl/feature_change_bio_impl.dart';
import 'package:feature_change_username_api/feature_change_username_api.dart';
import 'package:feature_change_username_impl/feature_change_username_impl.dart';
import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';
import 'package:feature_chat_administration_impl/feature_chat_administration_impl.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_header_info_impl/feature_chat_header_info_impl.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_contacts_api/feature_contacts_api.dart';
import 'package:feature_contacts_impl/feature_contacts_impl.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_country_impl/feature_country_impl.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_file_impl/feature_file_impl.dart';
import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_folders_impl/feature_folders_impl.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:feature_logout_impl/feature_logout_impl.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_message_preview_resolver_impl/feature_message_preview_resolver_impl.dart';
import 'package:feature_new_contact_api/feature_new_contact_api.dart';
import 'package:feature_new_contact_impl/feature_new_contact_impl.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_privacy_settings_impl/feature_privacy_settings_impl.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_sessions_api/feature_chat_api.dart';
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
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
import 'package:tg_logger_api/tg_logger_api.dart';
import 'package:theme_manager_api/theme_manager_api.dart';

import '../../navigation/router/chat_screen_router_factory.dart';

@j.module
abstract class FeatureModule {
  // region dependencies

  @j.provides
  static MainScreenFeatureDependencies provideMainScreenFeatureDependencies(
    IStringsProvider stringsProvider,
    IMainScreenRouter router,
    // todo do not depend on feature
    IGlobalSearchFeatureApi globalSearchFeatureApi,
    // todo do not depend on feature
    IChatsListFeatureApi chatsListFeatureApi,
    IConnectionStateProvider connectionStateProvider,
    IThemeManager themeManager,
    IUserRepository userRepository,
    OptionsManager optionsManager,
    IFileRepository fileRepository,
  ) =>
      MainScreenFeatureDependencies(
        themeManager: themeManager,
        userRepository: userRepository,
        stringsProvider: stringsProvider,
        fileRepository: fileRepository,
        router: router,
        connectionStateProvider: connectionStateProvider,
        chatsListScreenFactory: chatsListFeatureApi.chatsListScreenFactory,
        globalSearchScreenFactory:
            globalSearchFeatureApi.globalSearchScreenFactory,
        optionsManager: optionsManager,
      );

  @j.provides
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
          mode: Mode.chatPreview,
          userRepository: userRepository,
          stringsProvider: localizationManager.stringsProvider,
        ),
      );

  @j.provides
  static GlobalSearchFeatureDependencies provideGlobalSearchFeatureDependencies(
    IStringsProvider stringsProvider,
    IChatRepository chatRepository,
    IFileRepository fileRepository,
    IChatMessageRepository chatMessageRepository,
    IGlobalSearchFeatureRouter router,
  ) =>
      GlobalSearchFeatureDependencies(
        router: router,
        stringsProvider: stringsProvider,
        chatRepository: chatRepository,
        fileRepository: fileRepository,
        chatMessageRepository: chatMessageRepository,
      );

  @j.provides
  static ChatFeatureDependencies provideChatFeatureDependencies(
    IStringsProvider stringsProvider,
    DateParser dateParser,
    IFileRepository fileRepository,
    IUserRepository userRepository,
    IChatScreenRouterFactory routerFactory,
    IChatMessageRepository chatMessageRepository,
    IConnectionStateProvider connectionStateProvider,
    IChatRepository chatRepository,
    FeatureProvider featureProvider,
    DateFormatter dateFormatter,
    ISuperGroupUpdatesProvider superGroupUpdatesProvider,
    IBasicGroupUpdatesProvider basicGroupUpdatesProvider,
    IChatUpdatesProvider chatUpdatesProvider,
    IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi,
    ITdFunctionExecutor functionExecutor,
    ISuperGroupRepository superGroupRepository,
    IBasicGroupRepository basicGroupRepository,
    IChatMessagesUpdatesProvider chatMessagesUpdatesProvider,
    IChatManager chatManager,
    IErrorTransformer errorTransformer,
  ) =>
      ChatFeatureDependencies(
        errorTransformer: errorTransformer,
        chatManager: chatManager,
        chatMessagesUpdatesProvider: chatMessagesUpdatesProvider,
        chatUpdatesProvider: chatUpdatesProvider,
        basicGroupRepository: basicGroupRepository,
        superGroupUpdatesProvider: superGroupUpdatesProvider,
        basicGroupUpdatesProvider: basicGroupUpdatesProvider,
        superGroupRepository: superGroupRepository,
        functionExecutor: functionExecutor,
        dateFormatter: dateFormatter,
        fileDownloader: featureProvider.fileFeatureApi.fileDownloader,
        chatHeaderInfoFeatureApi: chatHeaderInfoFeatureApi,
        chatRepository: chatRepository,
        messagePreviewResolver: MessagePreviewResolver(
          messageRepository: chatMessageRepository,
          mode: Mode.replyPreview,
          chatRepository: chatRepository,
          userRepository: userRepository,
          stringsProvider: stringsProvider,
        ),
        connectionStateProvider: connectionStateProvider,
        chatMessageRepository: chatMessageRepository,
        routerFactory: routerFactory,
        dateParser: dateParser,
        fileRepository: fileRepository,
        userRepository: userRepository,
        stringsProvider: stringsProvider,
      );

  @j.provides
  static SettingsFeatureDependencies provideSettingsFeatureDependencies(
    ILocalizationManager localizationManager,
    ISettingsScreenRouter router,
    IFileRepository fileRepository,
    IUserRepository userRepository,
    OptionsManager optionsManager,
    // todo do not depend on feature
    ISettingsSearchFeatureApi settingsSearchFeatureApi,
  ) =>
      SettingsFeatureDependencies(
        optionsManager: optionsManager,
        userRepository: userRepository,
        fileRepository: fileRepository,
        localizationManager: localizationManager,
        router: router,
        settingsSearchFeatureApi: settingsSearchFeatureApi,
      );

  @j.provides
  static SettingsSearchFeatureDependencies
      provideSettingsSearchFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ISettingsSearchScreenRouter router,
    IStringsProvider stringsProvider,
  ) =>
          SettingsSearchFeatureDependencies(
            connectionStateProvider: connectionStateProvider,
            router: router,
            stringsProvider: stringsProvider,
          );

  @j.provides
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

  @j.provides
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

  @j.provides
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

  @j.provides
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

  @j.provides
  static WallpapersFeatureDependencies provideWallpapersFeatureDependencies(
    IBackgroundRepository backgroundRepository,
    FeatureProvider featureProvider,
    ILocalizationManager localizationManager,
    IWallpapersFeatureRouter router,
    IConnectionStateProvider connectionStateProvider,
  ) =>
      WallpapersFeatureDependencies(
        localizationManager: localizationManager,
        router: router,
        connectionStateProvider: connectionStateProvider,
        backgroundRepository: backgroundRepository,
        fileDownloader: featureProvider.fileFeatureApi.fileDownloader,
      );

  @j.provides
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

  @j.provides
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

  @j.provides
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

  @j.provides
  static SharedMediaFeatureDependencies provideSharedMediaFeatureDependencies(
    IChatMessageRepository messageRepository,
    ILocalizationManager localizationManager,
  ) =>
      SharedMediaFeatureDependencies(
        localizationManager: localizationManager,
        messageRepository: messageRepository,
      );

  @j.provides
  static CountryFeatureDependencies provideCountryFeatureDependencies(
    IStringsProvider stringsProvider,
  ) =>
      CountryFeatureDependencies(
        stringsProvider: stringsProvider,
      );

  @j.provides
  static AuthFeatureDependencies provideAuthFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    IStringsProvider stringsProvider,
    IAuthFeatureRouter router,
    IAuthenticationStateUpdatesProvider authenticationStateUpdatesProvider,
    ICountryFeatureApi countryFeatureApi,
    IAuthenticationManager authenticationManager,
    IErrorTransformer errorTransformer,
  ) =>
      AuthFeatureDependencies(
        errorTransformer: errorTransformer,
        connectionStateProvider: connectionStateProvider,
        stringsProvider: stringsProvider,
        router: router,
        authenticationStateUpdatesProvider: authenticationStateUpdatesProvider,
        countryRepository: countryFeatureApi.countryRepository,
        authenticationManager: authenticationManager,
      );

  @j.provides
  static LogoutFeatureDependencies provideLogoutFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    ILogoutFeatureRouter router,
    ITdFunctionExecutor functionExecutor,
    IAuthenticationManager authenticationManager,
  ) =>
      LogoutFeatureDependencies(
        connectionStateProvider: connectionStateProvider,
        localizationManager: localizationManager,
        router: router,
        authenticationManager: authenticationManager,
      );

  @j.provides
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

  @j.provides
  static FoldersFeatureDependencies provideFoldersFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    IFoldersRouter router,
    IStringsProvider stringsProvider,
  ) =>
      FoldersFeatureDependencies(
        stringsProvider: stringsProvider,
        connectionStateProvider: connectionStateProvider,
        router: router,
      );

  @j.provides
  static SessionsFeatureDependencies provideSessionsFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ISessionsScreenRouter router,
    ISessionRepository sessionRepository,
    IStringsProvider stringsProvider,
  ) =>
      SessionsFeatureDependencies(
        connectionStateProvider: connectionStateProvider,
        stringsProvider: stringsProvider,
        router: router,
        sessionRepository: sessionRepository,
      );

  @j.provides
  static CreateNewChatFeatureDependencies
      provideCreateNewChatFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    IStringsProvider stringsProvider,
    ICreateNewChatRouter router,
    IChatManager chatManager,
    IErrorTransformer errorTransformer,
    IBlockInteractionManager blockInteractionManager,
  ) =>
          CreateNewChatFeatureDependencies(
            errorTransformer: errorTransformer,
            blockInteractionManager: blockInteractionManager,
            chatManager: chatManager,
            router: router,
            connectionStateProvider: connectionStateProvider,
            stringsProvider: stringsProvider,
          );

  @j.provides
  static ContactsFeatureDependencies provideContactsFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    IContactsRouter router,
  ) =>
      ContactsFeatureDependencies(
        router: router,
        connectionStateProvider: connectionStateProvider,
        stringsProvider: localizationManager.stringsProvider,
      );

  @j.provides
  static NewContactFeatureDependencies provideNewContactFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    INewContactRouter router,
    IBlockInteractionManager blockInteractionManager,
    IFileRepository fileRepository,
    IUserRepository userRepository,
    IContactsManager contactsManager,
    IErrorTransformer errorTransformer,
  ) =>
      NewContactFeatureDependencies(
        errorTransformer: errorTransformer,
        contactsManager: contactsManager,
        router: router,
        userRepository: userRepository,
        fileRepository: fileRepository,
        blockInteractionManager: blockInteractionManager,
        connectionStateProvider: connectionStateProvider,
        stringsProvider: localizationManager.stringsProvider,
      );

  @j.provides
  static ChatAdministrationFeatureDependencies
      provideChatAdministrationFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    ILocalizationManager localizationManager,
    IChatAdministrationRouterFactory routerFactory,
    IBlockInteractionManager blockInteractionManager,
    IChatRepository chatRepository,
    IErrorTransformer errorTransformer,
    ISuperGroupRepository superGroupRepository,
    IBasicGroupRepository basicGroupRepository,
    IChatManager chatManager,
  ) =>
          ChatAdministrationFeatureDependencies(
            errorTransformer: errorTransformer,
            chatRepository: chatRepository,
            basicGroupRepository: basicGroupRepository,
            superGroupRepository: superGroupRepository,
            blockInteractionManager: blockInteractionManager,
            routerFactory: routerFactory,
            chatManager: chatManager,
            connectionStateProvider: connectionStateProvider,
            stringsProvider: localizationManager.stringsProvider,
          );

  @j.provides
  static ChangeUsernameFeatureDependencies
      provideChangeUsernameFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    IStringsProvider stringsProvider,
    IBlockInteractionManager blockInteractionManager,
    IErrorTransformer errorTransformer,
    IChangeUsernameRouter router,
    ITdFunctionExecutor functionExecutor,
    OptionsManager optionsManager,
    IUserRepository userRepository,
  ) =>
          ChangeUsernameFeatureDependencies(
            optionManager: optionsManager,
            userRepository: userRepository,
            functionExecutor: functionExecutor,
            router: router,
            errorTransformer: errorTransformer,
            blockInteractionManager: blockInteractionManager,
            connectionStateProvider: connectionStateProvider,
            stringsProvider: stringsProvider,
          );

  @j.provides
  static ChangeBioFeatureDependencies provideChangeBioFeatureDependencies(
    IConnectionStateProvider connectionStateProvider,
    IStringsProvider stringsProvider,
    IBlockInteractionManager blockInteractionManager,
    IErrorTransformer errorTransformer,
    IChangeBioRouter router,
  ) =>
      ChangeBioFeatureDependencies(
        router: router,
        errorTransformer: errorTransformer,
        blockInteractionManager: blockInteractionManager,
        connectionStateProvider: connectionStateProvider,
        stringsProvider: stringsProvider,
      );

  @j.provides
  static DevDependencies provideDevDependencies(
    IStringsProvider stringsProvider,
    IDevFeatureRouter router,
    ITdFunctionExecutor functionExecutor,
    IConnectionStateProvider connectionStateProvider,
    IEventsProvider eventsProvider,
    IThemeManager themeManager,
  ) =>
      DevDependencies(
        themeManager: themeManager,
        eventsProvider: eventsProvider,
        router: router,
        functionExecutor: functionExecutor,
        stringsProvider: stringsProvider,
        connectionStateProvider: connectionStateProvider,
      );

  // endregion dependencies

  // region api

  @j.provides
  static IGlobalSearchFeatureApi provideGlobalSearchFeatureApi(
    GlobalSearchFeatureDependencies dependencies,
  ) {
    return GlobalSearchFeature(dependencies: dependencies);
  }

  @j.provides
  static IMainScreenFeatureApi provideMainScreenFeatureApi(
    MainScreenFeatureDependencies dependencies,
  ) {
    return MainScreenFeature(dependencies: dependencies);
  }

  @j.provides
  static IChatHeaderInfoFeatureApi provideChatHeaderInfoFeatureApi(
    ChatHeaderInfoFeatureDependencies dependencies,
  ) {
    return ChatHeaderInfoFeature(dependencies: dependencies);
  }

  @j.provides
  static IChatFeatureApi provideChatFeatureApi(
    ChatFeatureDependencies dependencies,
  ) {
    return ChatFeature(dependencies: dependencies);
  }

  @j.provides
  static IChatsListFeatureApi provideChatsListFeatureApi(
    ChatsListFeatureDependencies dependencies,
  ) {
    return ChatsListFeature(dependencies: dependencies);
  }

  @j.provides
  static ISettingsFeatureApi provideSettingsFeatureApi(
    SettingsFeatureDependencies dependencies,
  ) {
    return SettingsFeature(dependencies: dependencies);
  }

  @j.provides
  static ISettingsSearchFeatureApi provideSettingsSearchFeatureApi(
    SettingsSearchFeatureDependencies dependencies,
  ) =>
      SettingsSearchFeature(dependencies: dependencies);

  @j.provides
  static IPrivacySettingsFeatureApi providePrivacySettingsFeatureApi(
    PrivacySettingsFeatureDependencies dependencies,
  ) =>
      PrivacySettingsFeature(dependencies: dependencies);

  @j.provides
  static INotificationsSettingsFeatureApi
      provideNotificationsSettingsFeatureApi(
    NotificationsSettingsFeatureDependencies dependencies,
  ) =>
          NotificationsSettingsFeatureApi(dependencies: dependencies);

  @j.provides
  static IDataSettingsFeatureApi provideDataSettingsFeatureApi(
    DataSettingsFeatureDependencies dependencies,
  ) =>
      DataSettingsFeature(dependencies: dependencies);

  @j.provides
  static IChatSettingsFeatureApi provideChatSettingsFeatureApi(
    ChatSettingsFeatureDependencies dependencies,
  ) =>
      ChatSettingsFeature(dependencies: dependencies);

  @j.provides
  static IWallpapersFeatureApi providewallpapersFeatureApi(
    WallpapersFeatureDependencies dependencies,
  ) =>
      WallpapersFeature(dependencies: dependencies);

  @j.provides
  static IStickersFeatureApi provideStickersFeatureApi(
    StickersFeatureDependencies dependencies,
  ) =>
      StickersFeature(dependencies: dependencies);

  @j.provides
  static IProfileFeatureApi provideProfileFeatureApi(
    ProfileFeatureDependencies dependencies,
  ) {
    return ProfileFeature(dependencies: dependencies);
  }

  @j.provides
  static ISharedMediaFeatureApi provideSharedMediaFeatureApi(
    SharedMediaFeatureDependencies dependencies,
  ) =>
      SharedMediaFeature(dependencies: dependencies);

  @j.provides
  static ICountryFeatureApi provideCountryFeatureApi(
    CountryFeatureDependencies dependencies,
  ) =>
      CountryFeature(dependencies: dependencies);

  @j.provides
  static IAuthFeatureApi provideAuthFeatureApi(
    AuthFeatureDependencies dependencies,
  ) =>
      AuthFeature(dependencies: dependencies);

  @j.provides
  static ILogoutFeatureApi provideLogoutFeatureApi(
    LogoutFeatureDependencies dependencies,
  ) =>
      LogoutFeature(dependencies: dependencies);

  @j.provides
  static IFileFeatureApi provideFileFeatureApi(
    FileFeatureDependencies dependencies,
  ) =>
      FileFeature(dependencies: dependencies);

  @j.provides
  static IFoldersFeatureApi provideFoldersFeatureApi(
    FoldersFeatureDependencies dependencies,
  ) =>
      FoldersFeatureImpl(dependencies: dependencies);

  @j.provides
  static ISessionsFeatureApi provideSessionsFeatureApi(
    SessionsFeatureDependencies dependencies,
  ) =>
      SessionsFeatureImpl(dependencies: dependencies);

  @j.provides
  static ICreateNewChatFeatureApi provideCreateNewChatFeatureApi(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      CreateNewChatFeature(dependencies: dependencies);

  @j.provides
  static IContactsFeatureApi provideContactsFeatureApi(
    ContactsFeatureDependencies dependencies,
  ) =>
      ContactsFeature(dependencies: dependencies);

  @j.provides
  static INewContactFeatureApi provideNewContactFeatureApi(
    NewContactFeatureDependencies dependencies,
  ) =>
      NewContactFeature(dependencies: dependencies);

  @j.provides
  static IChatAdministrationFeatureApi provideChatAdministrationFeatureApi(
    ChatAdministrationFeatureDependencies dependencies,
  ) =>
      ChatAdministrationFeature(dependencies: dependencies);

  @j.provides
  static IChangeUsernameFeatureApi provideChangeUsernameFeatureApi(
    ChangeUsernameFeatureDependencies dependencies,
  ) =>
      ChangeUsernameFeature(dependencies: dependencies);

  @j.provides
  static IChangeBioFeatureApi provideChangeBioFeatureApi(
    ChangeBioFeatureDependencies dependencies,
  ) =>
      ChangeBioFeature(dependencies: dependencies);

  // endregion api

  @j.provides
  static DevFeature provideDevFeature(
    DevDependencies dependencies,
  ) =>
      DevFeature(
        dependencies: dependencies,
      );

  // region router

  @j.provides
  @j.singleton
  static CommonScreenRouterImpl provideCommonScreenRouter(
    FeatureProvider featureProvider,
    ISplitNavigationDelegate navigationDelegate,
    KeyGenerator keyGenerator,
    ChatRouterDelegate chatRouterDelegate,
    ILogger logger,
  ) =>
      CommonScreenRouterImpl(
        logger: logger,
        chatRouterDelegate: chatRouterDelegate,
        dialogNavigatorKey: TgApp.navigatorKey,
        featureProvider: featureProvider,
        navigationDelegate: navigationDelegate,
        keyGenerator: keyGenerator,
      );

  @j.binds
  IChatsListScreenRouter bindChatsListScreenRouter(
    ChatsListScreenRouterImpl impl,
  );

  @j.binds
  IMainScreenRouter bindMainScreenRouter(CommonScreenRouterImpl impl);

  @j.binds
  IChatScreenRouterFactory bindChatScreenRouterFactory(
    ChatScreenRouterFactory impl,
  );

  @j.binds
  IProfileFeatureRouter bindProfileFeatureRouter(CommonScreenRouterImpl impl);

  @j.binds
  ISettingsScreenRouter bindSettingsScreenRouter(CommonScreenRouterImpl impl);

  @j.binds
  ISettingsSearchScreenRouter bindSettingsSearchScreenRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  IPrivacySettingsScreenRouter bindPrivacySettingsScreenRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  INotificationsSettingsScreenRouter bindNotificationsSettingsScreenRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  IDataSettingsScreenRouter bindDataSettingsScreenRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  IChatSettingsScreenRouter bindChatSettingsScreenRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  IDevFeatureRouter bindDevFeatureRouter(CommonScreenRouterImpl impl);

  @j.binds
  IWallpapersFeatureRouter bindwallpapersFeatureRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  IStickersFeatureRouter bindStickersFeatureRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  IAuthFeatureRouter bindAuthFeatureRouter(CommonScreenRouterImpl impl);

  @j.binds
  ILogoutFeatureRouter bindLogoutFeatureRouter(CommonScreenRouterImpl impl);

  @j.binds
  IGlobalSearchFeatureRouter bindGlobalSearchFeatureRouter(
    CommonScreenRouterImpl impl,
  );

  @j.binds
  IFoldersRouter bindFoldersRouter(CommonScreenRouterImpl impl);

  @j.binds
  ISessionsScreenRouter bindSessionsScreenRouter(CommonScreenRouterImpl impl);

  @j.binds
  ICreateNewChatRouter bindCreateNewChatRouter(CreateNewChatRouterImpl impl);

  @j.binds
  IContactsRouter bindContactsRouter(CommonScreenRouterImpl impl);

  @j.binds
  INewContactRouter bindNewContactRouter(NewContactRouterImpl impl);

  @j.binds
  IChatAdministrationRouterFactory bindChatAdministrationRouterFactory(
    ChatAdministrationRouterFactory impl,
  );

  @j.binds
  IChangeUsernameRouter bindChangeUsernameRouter(ChangeUsernameRouterImpl impl);

  @j.binds
  IChangeBioRouter bindChangeBioRouter(ChangeBioRouterImpl impl);
// endregion router

}
