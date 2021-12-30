import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_impl/src/screen/settings_page.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[SettingsModule])
abstract class SettingsScreenComponent {
  void inject(SettingsPageState screenState);
}

@j.module
abstract class SettingsModule {
  @j.provides
  @j.singleton
  static ISettingsSearchWidgetFactory provideSettingsSearchWidgetFactory(
    ISettingsSearchFeatureApi api,
  ) =>
      api.screenWidgetFactory;

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
}

@j.componentBuilder
abstract class SettingsComponentBuilder {
  SettingsComponentBuilder screenState(SettingsPageState screen);

  SettingsComponentBuilder dependencies(
    SettingsFeatureDependencies dependencies,
  );

  SettingsScreenComponent build();
}
