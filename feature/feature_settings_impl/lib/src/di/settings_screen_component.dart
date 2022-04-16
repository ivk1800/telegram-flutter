import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_impl/src/screen/setting_view_model.dart';
import 'package:feature_settings_impl/src/screen/settings_screen_content_interactor.dart';
import 'package:feature_settings_impl/src/screen/settings_screen_widget_model.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:user_info/user_info.dart';

@j.Component(
  modules: <Type>[SettingsScreenModule],
)
abstract class ISettingsComponent {
  ILocalizationManager getLocalizationManager();

  ISettingsSearchScreenFactory getSettingsSearchScreenFactory();

  SettingViewModel getSettingViewModel();

  SettingsScreenWidgetModel getSettingsScreenWidgetModel();

  tg.AvatarWidgetFactory getAvatarWidgetFactory();
}

@j.module
abstract class SettingsScreenModule {
  @j.provides
  @j.singleton
  static ISettingsSearchScreenFactory provideSettingsSearchScreenFactory(
    ISettingsSearchFeatureApi api,
  ) =>
      api.settingsSearchScreenFactory;

  @j.provides
  @j.singleton
  static ISettingsSearchFeatureApi provideSettingsSearchFeatureApi(
    SettingsFeatureDependencies dependencies,
  ) =>
      dependencies.settingsSearchFeatureApi;

  @j.provides
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    SettingsFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

  @j.singleton
  @j.provides
  static SettingViewModel provideSettingViewModel(
    SettingsFeatureDependencies dependencies,
    SettingsScreenContentInteractor contentInteractor,
  ) =>
      SettingViewModel(
        contentInteractor: contentInteractor,
        router: dependencies.router,
      )..init();

  @j.singleton
  @j.provides
  static SettingsScreenWidgetModel provideSettingsScreenWidgetModel(
    SettingsFeatureDependencies dependencies,
    SettingViewModel viewModel,
  ) =>
      SettingsScreenWidgetModel(
        viewModel: viewModel,
        settingsSearchScreenFactory:
            dependencies.settingsSearchFeatureApi.settingsSearchScreenFactory,
      )..init();

  @j.provides
  static SettingsScreenContentInteractor provideSettingsScreenContentInteractor(
    SettingsFeatureDependencies dependencies,
    UserInfoResolver userInfoResolver,
  ) =>
      SettingsScreenContentInteractor(
        userInfoResolver: userInfoResolver,
        optionsManager: dependencies.optionsManager,
      );

  @j.provides
  static tg.AvatarWidgetFactory provideAvatarWidgetFactory(
    SettingsFeatureDependencies dependencies,
  ) =>
      tg.AvatarWidgetFactory(
        fileRepository: dependencies.fileRepository,
      );

  @j.provides
  static UserInfoResolver provideUserInfoResolver(
    SettingsFeatureDependencies dependencies,
  ) =>
      UserInfoResolver(
        userRepository: dependencies.userRepository,
      );
}

@j.componentBuilder
abstract class ISettingsComponentBuilder {
  ISettingsComponentBuilder dependencies(
    SettingsFeatureDependencies dependencies,
  );

  ISettingsComponent build();
}
