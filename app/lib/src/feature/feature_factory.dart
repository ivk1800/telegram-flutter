import 'package:app/src/di/scope/application_scope.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_change_bio_api/feature_change_bio_api.dart';
import 'package:feature_change_username_api/feature_change_username_api.dart';
import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_forum_api/feature_chat_forum_api.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_contacts_api/feature_contacts_api.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_new_contact_api/feature_new_contact_api.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_sessions_api/feature_chat_api.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_wallpapers_api/feature_wallpapers_api.dart';
import 'package:jugger/jugger.dart' as j;

@applicationScope
class FeatureFactory {
  @j.inject
  FeatureFactory({
    required j.IProvider<IMainScreenFeatureApi> mainScreenFeatureApiProvider,
    required j.IProvider<IChatsListFeatureApi> chatsListFeatureApiProvider,
    required j.IProvider<IGlobalSearchFeatureApi>
        globalSearchFeatureApiProvider,
    required j.IProvider<IChatFeatureApi> chatFeatureApiProvider,
    required j.IProvider<ISettingsFeatureApi> settingsFeatureApiProvider,
    required j.IProvider<ISettingsSearchFeatureApi>
        settingsSearchFeatureApiProvider,
    required j.IProvider<IPrivacySettingsFeatureApi>
        privacySettingsFeatureApiProvider,
    required j.IProvider<INotificationsSettingsFeatureApi>
        notificationsSettingsFeatureApiProvider,
    required j.IProvider<IDataSettingsFeatureApi>
        dataSettingsFeatureApiProvider,
    required j.IProvider<IChatSettingsFeatureApi>
        chatSettingsFeatureApiProvider,
    required j.IProvider<IWallpapersFeatureApi> wallpapersFeatureApiProvider,
    required j.IProvider<IStickersFeatureApi> stickersFeatureApiProvider,
    required j.IProvider<IFoldersFeatureApi> foldersFeatureApiProvider,
    required j.IProvider<IProfileFeatureApi> profileFeatureApiProvider,
    required j.IProvider<ISharedMediaFeatureApi> sharedMediaFeatureApiProvider,
    required j.IProvider<DevFeature> devFeatureProvider,
    required j.IProvider<ICountryFeatureApi> countryFeatureApiProvider,
    required j.IProvider<IAuthFeatureApi> authFeatureApiProvider,
    required j.IProvider<ILogoutFeatureApi> logoutFeatureApiProvider,
    required j.IProvider<IFileFeatureApi> fileFeatureApiProvider,
    required j.IProvider<ISessionsFeatureApi> sessionsFeatureApiProvider,
    required j.IProvider<ICreateNewChatFeatureApi>
        createNewChatFeatureApiProvider,
    required j.IProvider<IContactsFeatureApi> contactsFeatureApiProvider,
    required j.IProvider<INewContactFeatureApi> newContactFeatureApiProvider,
    required j.IProvider<IChatAdministrationFeatureApi>
        chatAdministrationFeatureApiProvider,
    required j.IProvider<IChangeUsernameFeatureApi>
        changeUsernameFeatureApiProvider,
    required j.IProvider<IChangeBioFeatureApi> changeBioFeatureApiProvider,
    required j.IProvider<IChatForumFeatureApi> chatForumFeatureApiProvider,
  })  : _mainScreenFeatureApiProvider = mainScreenFeatureApiProvider,
        _chatsListFeatureApiProvider = chatsListFeatureApiProvider,
        _chatFeatureApiProvider = chatFeatureApiProvider,
        _settingsFeatureApiProvider = settingsFeatureApiProvider,
        _settingsSearchFeatureApiProvider = settingsSearchFeatureApiProvider,
        _privacySettingsFeatureApiProvider = privacySettingsFeatureApiProvider,
        _notificationsSettingsFeatureApiProvider =
            notificationsSettingsFeatureApiProvider,
        _dataSettingsFeatureApiProvider = dataSettingsFeatureApiProvider,
        _chatSettingsFeatureApiProvider = chatSettingsFeatureApiProvider,
        _wallpapersFeatureApiProvider = wallpapersFeatureApiProvider,
        _stickersFeatureApiProvider = stickersFeatureApiProvider,
        _foldersFeatureApiProvider = foldersFeatureApiProvider,
        _profileFeatureApiProvider = profileFeatureApiProvider,
        _sharedMediaFeatureApiProvider = sharedMediaFeatureApiProvider,
        _devFeatureProvider = devFeatureProvider,
        _countryFeatureApiProvider = countryFeatureApiProvider,
        _authFeatureApiProvider = authFeatureApiProvider,
        _logoutFeatureApiProvider = logoutFeatureApiProvider,
        _fileFeatureApiProvider = fileFeatureApiProvider,
        _sessionsFeatureApiProvider = sessionsFeatureApiProvider,
        _createNewChatFeatureApiProvider = createNewChatFeatureApiProvider,
        _contactsFeatureApiProvider = contactsFeatureApiProvider,
        _newContactFeatureApiProvider = newContactFeatureApiProvider,
        _chatAdministrationFeatureApiProvider =
            chatAdministrationFeatureApiProvider,
        _changeUsernameFeatureApiProvider = changeUsernameFeatureApiProvider,
        _changeBioFeatureApiProvider = changeBioFeatureApiProvider,
        _chatForumFeatureApiProvider = chatForumFeatureApiProvider,
        _globalSearchFeatureApiProvider = globalSearchFeatureApiProvider;

  final j.IProvider<IMainScreenFeatureApi> _mainScreenFeatureApiProvider;
  final j.IProvider<IChatsListFeatureApi> _chatsListFeatureApiProvider;
  final j.IProvider<IGlobalSearchFeatureApi> _globalSearchFeatureApiProvider;
  final j.IProvider<IChatFeatureApi> _chatFeatureApiProvider;
  final j.IProvider<ISettingsFeatureApi> _settingsFeatureApiProvider;
  final j.IProvider<ISettingsSearchFeatureApi>
      _settingsSearchFeatureApiProvider;
  final j.IProvider<IPrivacySettingsFeatureApi>
      _privacySettingsFeatureApiProvider;
  final j.IProvider<INotificationsSettingsFeatureApi>
      _notificationsSettingsFeatureApiProvider;
  final j.IProvider<IDataSettingsFeatureApi> _dataSettingsFeatureApiProvider;
  final j.IProvider<IChatSettingsFeatureApi> _chatSettingsFeatureApiProvider;
  final j.IProvider<IWallpapersFeatureApi> _wallpapersFeatureApiProvider;
  final j.IProvider<IStickersFeatureApi> _stickersFeatureApiProvider;
  final j.IProvider<IFoldersFeatureApi> _foldersFeatureApiProvider;
  final j.IProvider<IProfileFeatureApi> _profileFeatureApiProvider;
  final j.IProvider<ISharedMediaFeatureApi> _sharedMediaFeatureApiProvider;
  final j.IProvider<DevFeature> _devFeatureProvider;
  final j.IProvider<ICountryFeatureApi> _countryFeatureApiProvider;
  final j.IProvider<IAuthFeatureApi> _authFeatureApiProvider;
  final j.IProvider<ILogoutFeatureApi> _logoutFeatureApiProvider;
  final j.IProvider<IFileFeatureApi> _fileFeatureApiProvider;
  final j.IProvider<ISessionsFeatureApi> _sessionsFeatureApiProvider;
  final j.IProvider<ICreateNewChatFeatureApi> _createNewChatFeatureApiProvider;
  final j.IProvider<IContactsFeatureApi> _contactsFeatureApiProvider;
  final j.IProvider<INewContactFeatureApi> _newContactFeatureApiProvider;
  final j.IProvider<IChatAdministrationFeatureApi>
      _chatAdministrationFeatureApiProvider;
  final j.IProvider<IChangeUsernameFeatureApi>
      _changeUsernameFeatureApiProvider;
  final j.IProvider<IChangeBioFeatureApi> _changeBioFeatureApiProvider;
  final j.IProvider<IChatForumFeatureApi> _chatForumFeatureApiProvider;

  IMainScreenFeatureApi createMainScreenFeature() =>
      _mainScreenFeatureApiProvider.get();

  IChatsListFeatureApi createChatsListFeatureApi() =>
      _chatsListFeatureApiProvider.get();

  IGlobalSearchFeatureApi createGlobalSearchFeatureApi() =>
      _globalSearchFeatureApiProvider.get();

  IChatFeatureApi createChatFeatureApi() => _chatFeatureApiProvider.get();

  ISettingsFeatureApi createSettingsFeatureApi() =>
      _settingsFeatureApiProvider.get();

  ISettingsSearchFeatureApi createSettingsSearchFeatureApi() =>
      _settingsSearchFeatureApiProvider.get();

  IPrivacySettingsFeatureApi createPrivacySettingsFeatureApi() =>
      _privacySettingsFeatureApiProvider.get();

  INotificationsSettingsFeatureApi createNotificationsSettingsFeatureApi() =>
      _notificationsSettingsFeatureApiProvider.get();

  IDataSettingsFeatureApi createDataSettingsFeatureApi() =>
      _dataSettingsFeatureApiProvider.get();

  IChatSettingsFeatureApi createChatSettingsFeatureApi() =>
      _chatSettingsFeatureApiProvider.get();

  IWallpapersFeatureApi createWallpapersFeatureApi() =>
      _wallpapersFeatureApiProvider.get();

  IStickersFeatureApi createStickersFeatureApi() =>
      _stickersFeatureApiProvider.get();

  IFoldersFeatureApi createFoldersFeatureApi() =>
      _foldersFeatureApiProvider.get();

  IProfileFeatureApi createProfileFeatureApi() =>
      _profileFeatureApiProvider.get();

  ISharedMediaFeatureApi createSharedMediaFeatureApi() =>
      _sharedMediaFeatureApiProvider.get();

  DevFeature createDevFeature() => _devFeatureProvider.get();

  ICountryFeatureApi createCountryFeatureApi() =>
      _countryFeatureApiProvider.get();

  IAuthFeatureApi createAuthFeatureApi() => _authFeatureApiProvider.get();

  ILogoutFeatureApi createLogoutFeatureApi() => _logoutFeatureApiProvider.get();

  IFileFeatureApi createFileFeatureApi() => _fileFeatureApiProvider.get();

  ISessionsFeatureApi createSessionsFeatureApi() =>
      _sessionsFeatureApiProvider.get();

  ICreateNewChatFeatureApi createCreateNewChatFeatureApi() =>
      _createNewChatFeatureApiProvider.get();

  IContactsFeatureApi createContactsFeatureApi() =>
      _contactsFeatureApiProvider.get();

  INewContactFeatureApi createNewContactFeatureApi() =>
      _newContactFeatureApiProvider.get();

  IChatAdministrationFeatureApi createChatAdministrationFeatureApi() =>
      _chatAdministrationFeatureApiProvider.get();

  IChangeUsernameFeatureApi createChangeUsernameFeatureApi() =>
      _changeUsernameFeatureApiProvider.get();

  IChangeBioFeatureApi createChangeBioFeatureApi() =>
      _changeBioFeatureApiProvider.get();

  IChatForumFeatureApi createChatForumFeatureApi() =>
      _chatForumFeatureApiProvider.get();
}
