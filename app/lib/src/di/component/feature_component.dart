import 'package:app/src/di/component/app_component.dart';
import 'package:app/src/di/module/feature_module.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_change_bio_api/feature_change_bio_api.dart';
import 'package:feature_change_username_api/feature_change_username_api.dart';
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
import 'package:jugger/jugger.dart' as j;

import 'feature_component_builder.dart';

@j.Component(
  modules: <Type>[FeatureModule],
  dependencies: <Type>[IAppComponent],
  builder: IFeatureComponentBuilder,
)
abstract class IFeatureComponent {
  IGlobalSearchFeatureApi getGlobalSearchFeatureApi();

  IMainScreenFeatureApi getMainScreenFeatureApi();

  IChatsListFeatureApi getChatsListFeatureApi();

  IChatFeatureApi getChatListFeatureApi();

  ISettingsFeatureApi getSettingsFeatureApi();

  ISettingsSearchFeatureApi getSettingsSearchFeatureApi();

  DevFeature getDevFeature();

  IPrivacySettingsFeatureApi getPrivacySettingsFeatureApi();

  INotificationsSettingsFeatureApi getNotificationsSettingsFeatureApi();

  IDataSettingsFeatureApi getDataSettingsFeatureApi();

  IChatSettingsFeatureApi getChatSettingsFeatureApi();

  IWallpapersFeatureApi getWallpapersFeatureApi();

  IStickersFeatureApi getStickersFeatureApi();

  IFoldersFeatureApi getFoldersFeatureApi();

  IProfileFeatureApi getProfileFeatureApi();

  ISharedMediaFeatureApi getSharedMediaFeatureApi();

  ICountryFeatureApi getCountryFeatureApi();

  IAuthFeatureApi getAuthFeatureApi();

  ILogoutFeatureApi getLogoutFeatureApi();

  IFileFeatureApi getFileFeatureApi();

  ISessionsFeatureApi getSessionsFeatureApi();

  ICreateNewChatFeatureApi getCreateNewChatFeatureApi();

  IContactsFeatureApi getContactsFeatureApi();

  INewContactFeatureApi getNewContactFeatureApi();

  IChatAdministrationFeatureApi getChatAdministrationFeatureApi();

  IChangeUsernameFeatureApi getChangeUsernameFeatureApi();

  IChangeBioFeatureApi getChangeBioFeatureApi();
}
