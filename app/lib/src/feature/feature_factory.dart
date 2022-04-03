import 'package:app/src/di/component/feature_component.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
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

class FeatureFactory {
  FeatureFactory({required IFeatureComponent featureComponent})
      : _featureComponent = featureComponent;

  final IFeatureComponent _featureComponent;

  IMainScreenFeatureApi createMainScreenFeature() =>
      _featureComponent.getMainScreenFeatureApi();

  IChatsListFeatureApi createChatsListFeatureApi() =>
      _featureComponent.getChatsListFeatureApi();

  IGlobalSearchFeatureApi createGlobalSearchFeatureApi() =>
      _featureComponent.getGlobalSearchFeatureApi();

  IChatFeatureApi createChatFeatureApi() =>
      _featureComponent.getChatListFeatureApi();

  ISettingsFeatureApi createSettingsFeatureApi() =>
      _featureComponent.getSettingsFeatureApi();

  ISettingsSearchFeatureApi createSettingsSearchFeatureApi() =>
      _featureComponent.getSettingsSearchFeatureApi();

  IPrivacySettingsFeatureApi createPrivacySettingsFeatureApi() =>
      _featureComponent.getPrivacySettingsFeatureApi();

  INotificationsSettingsFeatureApi createNotificationsSettingsFeatureApi() =>
      _featureComponent.getNotificationsSettingsFeatureApi();

  IDataSettingsFeatureApi createDataSettingsFeatureApi() =>
      _featureComponent.getDataSettingsFeatureApi();

  IChatSettingsFeatureApi createChatSettingsFeatureApi() =>
      _featureComponent.getChatSettingsFeatureApi();

  IWallpapersFeatureApi createWallpapersFeatureApi() =>
      _featureComponent.getWallpapersFeatureApi();

  IStickersFeatureApi createStickersFeatureApi() =>
      _featureComponent.getStickersFeatureApi();

  IFoldersFeatureApi createFoldersFeatureApi() =>
      _featureComponent.getFoldersFeatureApi();

  IProfileFeatureApi createProfileFeatureApi() =>
      _featureComponent.getProfileFeatureApi();

  ISharedMediaFeatureApi createSharedMediaFeatureApi() =>
      _featureComponent.getSharedMediaFeatureApi();

  DevFeature createDevFeature() => _featureComponent.getDevFeature();

  ICountryFeatureApi createCountryFeatureApi() =>
      _featureComponent.getCountryFeatureApi();

  IAuthFeatureApi createAuthFeatureApi() =>
      _featureComponent.getAuthFeatureApi();

  ILogoutFeatureApi createLogoutFeatureApi() =>
      _featureComponent.getLogoutFeatureApi();

  IFileFeatureApi createFileFeatureApi() =>
      _featureComponent.getFileFeatureApi();

  ISessionsFeatureApi createSessionsFeatureApi() =>
      _featureComponent.getSessionsFeatureApi();

  ICreateNewChatFeatureApi createCreateNewChatFeatureApi() =>
      _featureComponent.getCreateNewChatFeatureApi();

  IContactsFeatureApi createContactsFeatureApi() =>
      _featureComponent.getContactsFeatureApi();

  INewContactFeatureApi createNewContactFeatureApi() =>
      _featureComponent.getNewContactFeatureApi();

  IChatAdministrationFeatureApi createChatAdministrationFeatureApi() =>
      _featureComponent.getChatAdministrationFeatureApi();
}
