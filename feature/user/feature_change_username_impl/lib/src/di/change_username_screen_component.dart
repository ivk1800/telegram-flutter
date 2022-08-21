import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_change_username_impl/feature_change_username_impl.dart';
import 'package:feature_change_username_impl/src/change_username_feature_dependencies.dmg.dart';
import 'package:feature_change_username_impl/src/screen/change_username/change_username_screen_scope_delegate.dart';
import 'package:feature_change_username_impl/src/screen/username_checker.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:user_info/user_info.dart';

import 'change_username_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    ChangeUsernameScreenModule,
    TgAppBarModule,
    ChangeUsernameFeatureDependenciesModule
  ],
  builder: IChangeUsernameScreenComponentBuilder,
)
@j.singleton
abstract class IChangeUsernameScreenComponent
    implements IChangeUsernameScreenScopeDelegate {}

@j.module
abstract class ChangeUsernameScreenModule {
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
    IUserRepository userRepository,
  ) =>
      UserInfoResolver(userRepository: userRepository);
}
