import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_impl/src/screen/settings_screen_content_interactor.dart';
import 'package:feature_settings_impl/src/screen/settings_screen_scope_delegate.dart';
import 'package:feature_settings_impl/src/settings_feature_dependencies.dmg.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:user_info/user_info.dart';

@j.Component(
  modules: <Type>[
    SettingsScreenModule,
    SettingsFeatureDependenciesModule,
  ],
)
abstract class ISettingsComponent implements ISettingsScreenScopeDelegate {}

@j.module
abstract class SettingsScreenModule {
  @j.provides
  static SettingsScreenContentInteractor provideSettingsScreenContentInteractor(
    IStringsProvider stringsProvider,
    OptionsManager optionsManager,
    UserInfoResolver userInfoResolver,
  ) =>
      SettingsScreenContentInteractor(
        stringsProvider: stringsProvider,
        userInfoResolver: userInfoResolver,
        optionsManager: optionsManager,
      );

  @j.provides
  static tg.AvatarWidgetFactory provideAvatarWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      tg.AvatarWidgetFactory(fileDownloader: fileDownloader);

  @j.provides
  static UserInfoResolver provideUserInfoResolver(
    IUserRepository userRepository,
  ) =>
      UserInfoResolver(userRepository: userRepository);
}

@j.componentBuilder
abstract class ISettingsComponentBuilder {
  ISettingsComponentBuilder dependencies(
    SettingsFeatureDependencies dependencies,
  );

  ISettingsComponent build();
}
