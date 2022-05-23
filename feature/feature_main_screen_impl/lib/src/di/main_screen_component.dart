import 'package:coreui/coreui.dart' as tg;
import 'package:coreui/coreui.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_main_screen_impl/src/screen/main/header_view_model.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_screen_widget_model.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:user_info/user_info.dart';

@j.Component(
  modules: <Type>[MainScreenModule],
)
abstract class IMainScreenComponent {
  MainViewModel getMainViewModel();

  HeaderViewModel getHeaderViewModel();

  MainScreenWidgetModel getMainScreenWidgetModel();

  IStringsProvider getStringsProvider();

  IGlobalSearchScreenFactory getGlobalSearchScreenFactory();

  IChatsListScreenFactory getChatsListScreenFactory();

  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();

  tg.AvatarWidgetFactory getAvatarWidgetFactory();
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
        chatsListScreenFactory: dependencies.chatsListScreenFactory,
        globalSearchScreenFactory: dependencies.globalSearchScreenFactory,
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
  static HeaderViewModel provideHeaderViewModel(
    MainScreenFeatureDependencies dependencies,
    UserInfoResolver userInfoResolver,
  ) =>
      HeaderViewModel(
        optionsManager: dependencies.optionsManager,
        userInfoResolver: userInfoResolver,
        themeManager: dependencies.themeManager,
      )..init();

  @j.provides
  @j.singleton
  static UserInfoResolver provideUserInfoResolver(
    MainScreenFeatureDependencies dependencies,
  ) =>
      UserInfoResolver(
        userRepository: dependencies.userRepository,
      );

  @j.provides
  @j.singleton
  static tg.AvatarWidgetFactory provideAvatarWidgetFactory(
    MainScreenFeatureDependencies dependencies,
  ) =>
      AvatarWidgetFactory(
        fileRepository: dependencies.fileRepository,
      );

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
  static IGlobalSearchScreenFactory provideGlobalSearchScreenFactory(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.globalSearchScreenFactory;

  @j.provides
  @j.singleton
  static IChatsListScreenFactory provideChatsListWidgetFactory(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.chatsListScreenFactory;

  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    MainScreenFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;
}

@j.componentBuilder
abstract class IMainScreenComponentBuilder {
  IMainScreenComponentBuilder dependencies(
    MainScreenFeatureDependencies dependencies,
  );

  IMainScreenComponent build();
}
