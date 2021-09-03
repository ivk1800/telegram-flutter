library feature_main_screen_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'src/di/main_screen_component.dart';
import 'src/main_screen_router.dart';
import 'src/screen/main_page.dart';

export 'src/main_screen_router.dart';

class MainScreenFeatureApi implements IMainScreenFeatureApi {
  MainScreenFeatureApi({
    required MainScreenFeatureDependencies dependencies,
  }) : _screenWidgetFactory = _ScreenWidgetFactory(dependencies: dependencies);

  final IMainScreenWidgetFactory _screenWidgetFactory;

  @override
  IMainScreenWidgetFactory get screenWidgetFactory => _screenWidgetFactory;
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

class _ScreenWidgetFactory implements IMainScreenWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final MainScreenFeatureDependencies dependencies;

  @override
  Widget create() => const MainPage().wrap(dependencies);
}
