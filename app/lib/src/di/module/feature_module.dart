import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/feature.dart';
import 'package:presentation/src/navigation/chats_list_screen_router_impl.dart';
import 'package:presentation/src/navigation/split_navigation_router.dart';

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
  static IChatsListFeatureApi provideChatsListFeatureApi(
      IChatsListFeatureDependencies dependencies) {
    return ChatsListFeatureApi(dependencies: dependencies);
  }

  @j.bind
  IChatsListScreenRouter bindChatsListScreenRouter(
      ChatsListScreenRouterImpl impl);
}
