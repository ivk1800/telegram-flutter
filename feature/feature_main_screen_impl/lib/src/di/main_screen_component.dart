import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[MainScreenModule])
abstract class MainScreenComponent {
  MainViewModel getMainViewModel();

  ILocalizationManager getLocalizationManager();

  IGlobalSearchScreenFactory getGlobalSearchScreenFactory();

  IChatsListScreenFactory getChatsListScreenFactory();

  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();
}

@j.module
abstract class MainScreenModule {
  @j.provide
  @j.singleton
  static MainViewModel provideMainViewModel(
    MainScreenFeatureDependencies dependencies,
  ) =>
      MainViewModel(
        router: dependencies.router,
      );

  @j.provide
  @j.singleton
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    MainScreenFeatureDependencies dependencies,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: dependencies.connectionStateProvider,
      );

  @j.provide
  @j.singleton
  static IGlobalSearchFeatureApi provideGlobalSearchFeatureApi(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.globalSearchFeatureApi;

  @j.provide
  @j.singleton
  static IGlobalSearchScreenFactory provideGlobalSearchScreenFactory(
          IGlobalSearchFeatureApi api) =>
      api.globalSearchScreenFactory;

  @j.provide
  @j.singleton
  static IChatsListFeatureApi provideChatsListFeatureApi(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.chatsListFeatureApi;

  @j.provide
  @j.singleton
  static IChatsListScreenFactory provideChatsListWidgetFactory(
          IChatsListFeatureApi api) =>
      api.chatsListScreenFactory;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideConnectionStateProvider(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.connectionStateProvider;

  @j.provide
  @j.singleton
  static IMainScreenRouter provideMainRouter(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.router;

  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;
}

@j.componentBuilder
abstract class FoldersSetupComponentBuilder {
  FoldersSetupComponentBuilder dependencies(
    MainScreenFeatureDependencies dependencies,
  );

  MainScreenComponent build();
}
