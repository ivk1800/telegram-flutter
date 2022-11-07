import 'package:app/src/di/scope/application_scope.dart';
import 'package:app/src/feature/feature.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_change_bio_api/feature_change_bio_api.dart';
import 'package:feature_change_username_api/feature_change_username_api.dart';
import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_forum_api/feature_chat_forum_api.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_contacts_api/feature_contacts_api.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_new_contact_api/feature_new_contact_api.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_sessions_api/feature_chat_api.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_wallpapers_api/feature_wallpapers_api.dart';
import 'package:jugger/jugger.dart' as j;

@applicationScope
class FeatureProvider {
  @j.inject
  FeatureProvider({
    required FeatureFactory featureFactory,
  }) : _featureFactory = featureFactory;

  final FeatureFactory _featureFactory;

  late final IAuthFeatureApi authFeatureApi =
      _featureFactory.createAuthFeatureApi();

  late final IMainScreenFeatureApi mainScreenFeatureApi =
      _featureFactory.createMainScreenFeature();

  late final IFileFeatureApi fileFeatureApi =
      _featureFactory.createFileFeatureApi();

  late final ICountryFeatureApi countryFeatureApi =
      _featureFactory.createCountryFeatureApi();

  late final IChatFeatureApi chatFeatureApi =
      _featureFactory.createChatFeatureApi();

  late final IProfileFeatureApi profileFeatureApi =
      _featureFactory.createProfileFeatureApi();

  late final ISharedMediaFeatureApi sharedMediaFeatureApi =
      _featureFactory.createSharedMediaFeatureApi();

  late final INotificationsSettingsFeatureApi notificationsSettingsFeatureApi =
      _featureFactory.createNotificationsSettingsFeatureApi();

  late final IStickersFeatureApi stickersFeatureApi =
      _featureFactory.createStickersFeatureApi();

  late final IFoldersFeatureApi foldersFeatureApi =
      _featureFactory.createFoldersFeatureApi();

  late final ISessionsFeatureApi sessionsFeatureApi =
      _featureFactory.createSessionsFeatureApi();

  late final IPrivacySettingsFeatureApi privacySettingsFeatureApi =
      _featureFactory.createPrivacySettingsFeatureApi();

  late final IDataSettingsFeatureApi dataSettingsFeatureApi =
      _featureFactory.createDataSettingsFeatureApi();

  late final IChatSettingsFeatureApi chatSettingsFeatureApi =
      _featureFactory.createChatSettingsFeatureApi();

  late final ILogoutFeatureApi logoutFeatureApi =
      _featureFactory.createLogoutFeatureApi();

  late final IWallpapersFeatureApi wallpapersFeatureApi =
      _featureFactory.createWallpapersFeatureApi();

  late final DevFeature devFeature = _featureFactory.createDevFeature();

  late final ISettingsFeatureApi settingsFeatureApi =
      _featureFactory.createSettingsFeatureApi();

  late final ICreateNewChatFeatureApi newChatFeatureApi =
      _featureFactory.createCreateNewChatFeatureApi();

  late final IContactsFeatureApi contactsFeatureApi =
      _featureFactory.createContactsFeatureApi();

  late final INewContactFeatureApi newContactFeatureApi =
      _featureFactory.createNewContactFeatureApi();

  late final IChatAdministrationFeatureApi chatAdministrationFeatureApi =
      _featureFactory.createChatAdministrationFeatureApi();

  late final IChangeUsernameFeatureApi changeUsernameFeatureApi =
      _featureFactory.createChangeUsernameFeatureApi();

  late final IChangeBioFeatureApi changeBioFeatureApi =
      _featureFactory.createChangeBioFeatureApi();

  late final IChatForumFeatureApi chatForumFeatureApi =
      _featureFactory.createChatForumFeatureApi();
}
