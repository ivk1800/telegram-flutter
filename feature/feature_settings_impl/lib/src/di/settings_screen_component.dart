import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_impl/src/screen/setting_view_model.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[SettingsModule])
abstract class SettingsScreenComponent {
  ILocalizationManager getLocalizationManager();

  tg.ConnectionStateWidgetFactory getConnectionStateWidgetFactory();

  tg.TgAppBarFactory getTgAppBarFactory();

  ISettingsSearchScreenFactory getSettingsSearchWidgetFactory();

  SettingViewModel getSettingViewModel();
}

@j.module
abstract class SettingsModule {
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

  @j.provides
  @j.singleton
  static IConnectionStateProvider provideConnectionStateProvider(
    SettingsFeatureDependencies dependencies,
  ) =>
      dependencies.connectionStateProvider;

  @j.provides
  @j.singleton
  static ISettingsScreenRouter provideRouter(
    SettingsFeatureDependencies dependencies,
  ) =>
      dependencies.router;

  @j.singleton
  @j.provides
  static ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );

  @j.singleton
  @j.provides
  static SettingViewModel provideSettingViewModel(
    SettingsFeatureDependencies dependencies,
  ) =>
      SettingViewModel(
        router: dependencies.router,
      );

  @j.singleton
  @j.provides
  static tg.TgAppBarFactory provideTgAppBarFactory(
    ConnectionStateWidgetFactory connectionStateWidgetFactory,
  ) =>
      TgAppBarFactory(
        connectionStateWidgetFactory: connectionStateWidgetFactory,
      );
}

@j.componentBuilder
abstract class SettingsComponentBuilder {
  SettingsComponentBuilder dependencies(
    SettingsFeatureDependencies dependencies,
  );

  SettingsScreenComponent build();
}
