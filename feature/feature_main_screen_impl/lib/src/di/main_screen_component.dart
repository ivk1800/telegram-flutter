import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_screen_widget_model.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[MainScreenModule],
)
abstract class IMainScreenComponent {
  MainViewModel getMainViewModel();

  MainScreenWidgetModel getMainScreenWidgetModel();

  IStringsProvider getStringsProvider();

  IGlobalSearchScreenFactory getGlobalSearchScreenFactory();

  IChatsListScreenFactory getChatsListScreenFactory();

  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();
}

@j.module
abstract class MainScreenModule {
  @j.provides
  @j.singleton
  static MainScreenWidgetModel provideMainScreenWidgetModel(
    MainScreenFeatureDependencies dependencies,
    MainViewModel viewModel,
  ) =>
      MainScreenWidgetModel(
        viewModel: viewModel,
        chatsListScreenFactory:
            dependencies.chatsListFeatureApi.chatsListScreenFactory,
        globalSearchScreenFactory:
            dependencies.globalSearchFeatureApi.globalSearchScreenFactory,
      );

  @j.provides
  @j.singleton
  static MainViewModel provideMainViewModel(
    MainScreenFeatureDependencies dependencies,
  ) =>
      MainViewModel(
        router: dependencies.router,
      )..init();

  @j.provides
  @j.singleton
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    MainScreenFeatureDependencies dependencies,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: dependencies.connectionStateProvider,
      );

  @j.provides
  @j.singleton
  static IGlobalSearchFeatureApi provideGlobalSearchFeatureApi(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.globalSearchFeatureApi;

  @j.provides
  @j.singleton
  static IGlobalSearchScreenFactory provideGlobalSearchScreenFactory(
    IGlobalSearchFeatureApi api,
  ) =>
      api.globalSearchScreenFactory;

  @j.provides
  @j.singleton
  static IChatsListFeatureApi provideChatsListFeatureApi(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.chatsListFeatureApi;

  @j.provides
  @j.singleton
  static IChatsListScreenFactory provideChatsListWidgetFactory(
    IChatsListFeatureApi api,
  ) =>
      api.chatsListScreenFactory;

  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager.stringsProvider;
}

@j.componentBuilder
abstract class IMainScreenComponentBuilder {
  IMainScreenComponentBuilder dependencies(
    MainScreenFeatureDependencies dependencies,
  );

  IMainScreenComponent build();
}
