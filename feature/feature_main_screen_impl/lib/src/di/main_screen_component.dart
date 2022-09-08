import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:coreui/coreui.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_main_screen_impl/src/main_screen_feature_dependencies.dmg.dart';
import 'package:feature_main_screen_impl/src/screen/main/folders_interactor.dart';
import 'package:feature_main_screen_impl/src/screen/main/main_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:user_info/user_info.dart';

import 'main_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    MainScreenModule,
    MainScreenFeatureDependenciesModule,
  ],
  builder: IMainScreenComponentBuilder,
)
@j.singleton
abstract class IMainScreenComponent implements IMainScreenScopeDelegate {}

@j.module
abstract class MainScreenModule {
  @j.provides
  static FoldersInteractor provideFoldersInteractor(
    IChatFilterRepository chatFilterRepository,
  ) =>
      FoldersInteractor(chatFilterRepository: chatFilterRepository);

  @j.provides
  @j.singleton
  static UserInfoResolver provideUserInfoResolver(
    IUserRepository userRepository,
  ) =>
      UserInfoResolver(userRepository: userRepository);

  @j.provides
  @j.singleton
  static tg.AvatarWidgetFactory provideAvatarWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      AvatarWidgetFactory(fileDownloader: fileDownloader);

  // todo extract shared module
  @j.provides
  @j.singleton
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );
}
