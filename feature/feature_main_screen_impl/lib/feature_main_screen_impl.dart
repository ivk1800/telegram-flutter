library feature_main_screen_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/main_screen_router.dart';
import 'src/screen/main/main_screen_factory.dart';

export 'src/main_screen_router.dart';

class MainScreenFeatureApi implements IMainScreenFeatureApi {
  MainScreenFeatureApi({
    required MainScreenFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final MainScreenFeatureDependencies _dependencies;
  MainScreenFactory? _mainScreenFactory;

  @override
  IMainScreenFactory get mainScreenFactory =>
      _mainScreenFactory ?? MainScreenFactory(dependencies: _dependencies);
}

class MainScreenFeatureDependencies {
  const MainScreenFeatureDependencies({
    required this.globalSearchFeatureApi,
    required this.chatsListFeatureApi,
    required this.connectionStateProvider,
    required this.router,
    required this.localizationManager,
  });

  final IGlobalSearchFeatureApi globalSearchFeatureApi;

  final IChatsListFeatureApi chatsListFeatureApi;

  final IConnectionStateProvider connectionStateProvider;

  final IMainScreenRouter router;

  final ILocalizationManager localizationManager;
}
