import 'package:coreui/coreui.dart' as tg;
import 'package:feature_change_username_impl/feature_change_username_impl.dart';
import 'package:feature_change_username_impl/src/screen/change_username/change_username_screen_widget_model.dart';
import 'package:feature_change_username_impl/src/screen/change_username/change_username_view_model.dart';
import 'package:feature_change_username_impl/src/screen/username_checker.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:user_info/user_info.dart';

@j.Component(
  modules: <Type>[ChangeUsernameScreenModule],
)
abstract class IChangeUsernameScreenComponent {
  IStringsProvider getStringsProvider();

  ChangeUsernameViewModel getChangeUsernameViewModel();

  tg.TgAppBarFactory getTgAppBarFactory();

  ChangeUsernameScreenWidgetModel getChangeUsernameScreenWidgetModel();
}

@j.module
abstract class ChangeUsernameScreenModule {
  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    ChangeUsernameFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  @j.singleton
  static ChangeUsernameViewModel provideChangeUsernameViewModel(
    ChangeUsernameFeatureDependencies dependencies,
    UsernameChecker usernameChecker,
    UserInfoResolver userInfoResolver,
  ) =>
      ChangeUsernameViewModel(
        functionExecutor: dependencies.functionExecutor,
        optionsManager: dependencies.optionManager,
        userInfoResolver: userInfoResolver,
        errorTransformer: dependencies.errorTransformer,
        stringsProvider: dependencies.stringsProvider,
        usernameChecker: usernameChecker,
        blockInteractionManager: dependencies.blockInteractionManager,
        router: dependencies.router,
      )..init();

  @j.provides
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    ChangeUsernameFeatureDependencies dependencies,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: dependencies.connectionStateProvider,
      );

  @j.provides
  static tg.TgAppBarFactory provideTgAppBarFactory(
    tg.ConnectionStateWidgetFactory connectionStateWidgetFactory,
  ) =>
      tg.TgAppBarFactory(
        connectionStateWidgetFactory: connectionStateWidgetFactory,
      );

  @j.provides
  @j.singleton
  static ChangeUsernameScreenWidgetModel provideChangeUsernameScreenWidgetModel(
    ChangeUsernameViewModel viewModel,
  ) =>
      ChangeUsernameScreenWidgetModel(viewModel: viewModel);

  @j.provides
  static UsernameChecker provideUsernameChecker(
    ChangeUsernameFeatureDependencies dependencies,
  ) =>
      UsernameChecker(
        optionsManager: dependencies.optionManager,
        functionExecutor: dependencies.functionExecutor,
        stringsProvider: dependencies.stringsProvider,
      );

  @j.provides
  @j.singleton
  static UserInfoResolver provideUserInfoResolver(
    ChangeUsernameFeatureDependencies dependencies,
  ) =>
      UserInfoResolver(userRepository: dependencies.userRepository);
}

@j.componentBuilder
abstract class IChangeUsernameScreenComponentBuilder {
  IChangeUsernameScreenComponentBuilder dependencies(
    ChangeUsernameFeatureDependencies dependencies,
  );

  IChangeUsernameScreenComponent build();
}
