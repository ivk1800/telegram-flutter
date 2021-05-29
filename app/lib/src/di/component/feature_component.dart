import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_wallpappers_api/feature_wallpappers_api.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_component.dart';
import 'package:presentation/src/di/module/feature_module.dart';
import 'package:feature_chat_api/feature_chat_api.dart';

@j.Component(modules: <Type>[FeatureModule], dependencies: <Type>[AppComponent])
abstract class FeatureComponent {
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

  IWallpappersFeatureApi getWallpappersFeatureApi();
}

@j.componentBuilder
abstract class FeatureComponentBuilder {
  FeatureComponentBuilder appComponent(AppComponent appComponent);

  FeatureComponent build();
}
