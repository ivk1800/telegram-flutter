import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/screen/main_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'main_screen_component.jugger.dart';

@j.Component(modules: <Type>[FoldersSetupModule])
abstract class MainScreenComponent
    implements IWidgetStateComponent<MainPage, MainPageState> {
  @override
  void inject(MainPageState screenState);
}

@j.module
abstract class FoldersSetupModule {
  @j.provide
  @j.singleton
  static IGlobalSearchFeatureApi provideGlobalSearchFeatureApi(
          MainScreenFeatureDependencies dependencies) =>
      dependencies.globalSearchFeatureApi;

  @j.provide
  @j.singleton
  static IGlobalSearchWidgetFactory provideGlobalSearchWidgetFactory(
          IGlobalSearchFeatureApi api) =>
      api.screenWidgetFactory;

  @j.provide
  @j.singleton
  static IChatsListFeatureApi provideChatsListFeatureApi(
          MainScreenFeatureDependencies dependencies) =>
      dependencies.chatsListFeatureApi;

  @j.provide
  @j.singleton
  static IChatsListWidgetFactory provideChatsListWidgetFactory(
          IChatsListFeatureApi api) =>
      api.screenWidgetFactory;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideconnectionStateProvider(
          MainScreenFeatureDependencies dependencies) =>
      dependencies.connectionStateProvider;

  @j.provide
  @j.singleton
  static IMainScreenRouter provideMainRouter(
          MainScreenFeatureDependencies dependencies) =>
      dependencies.router;

  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
          MainScreenFeatureDependencies dependencies) =>
      dependencies.localizationManager;
}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder screenState(MainPageState screen);

  FoldersSetupComponentBuilder dependencies(
      MainScreenFeatureDependencies dependencies);

  MainScreenComponent build();
}

extension FoldersSetupComponentExt on MainPage {
  Widget wrap(MainScreenFeatureDependencies dependencies) =>
      ComponentHolder<MainPage, MainPageState>(
        componentFactory: (MainPageState state) =>
            JuggerMainScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
