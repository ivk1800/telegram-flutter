import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/chat_feature_dependencies.dart';
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/navigation/chat_screen_router_impl.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:td_client/td_client.dart';

@j.module
abstract class FeatureModule {
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
  static DevFeature provideDevFeature(TdClient client,
          IConnectionStateUpdatesProvider connectionStateUpdatesProvider) =>
      DevFeature(
          connectionStateUpdatesProvider: connectionStateUpdatesProvider,
          client: client);

  @j.bind
  IChatsListScreenRouter bindChatsListScreenRouter(
      ChatsListScreenRouterImpl impl);

  @j.bind
  IMainScreenRouter bindMainScreenRouter(MainScreenRouterImpl impl);

  @j.bind
  IChatScreenRouter bindChatScreenRouter(ChatScreenRouterImpl impl);

  @j.bind
  ISettingsScreenRouter bindSettingsScreenRouter(SettingsScreenRouterImpl impl);

  @j.bind
  ISettingsSearchScreenRouter bindSettingsSearchScreenRouter(
      SettingsSearchScreenRouterImpl impl);
}
