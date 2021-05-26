import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_impl/src/screen/settings_page.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'settings_screen_component.jugger.dart';

@j.Component(modules: <Type>[SettingsModule])
abstract class SettingsScreenComponent
    implements IWidgetStateComponent<SettingsPage, SettingsPageState> {
  @override
  void inject(SettingsPageState screenState);
}

@j.module
abstract class SettingsModule {
  @j.provide
  @j.singleton
  static ISettingsSearchWidgetFactory provideSettingsSearchWidgetFactory(
          ISettingsSearchFeatureApi api) =>
      api.screenWidgetFactory;

  @j.provide
  @j.singleton
  static ISettingsSearchFeatureApi provideSettingsSearchFeatureApi(
          ISettingsFeatureDependencies dependencies) =>
      dependencies.settingsSearchFeatureApi;

  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
          ISettingsFeatureDependencies dependencies) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideconnectionStateProvider(
          ISettingsFeatureDependencies dependencies) =>
      dependencies.connectionStateProvider;

  @j.provide
  @j.singleton
  static ISettingsScreenRouter provideRouter(
          ISettingsFeatureDependencies dependencies) =>
      dependencies.router;
}

@j.componentBuilder
abstract class SettingsComponentBuilder {
  SettingsComponentBuilder screenState(SettingsPageState screen);

  SettingsComponentBuilder dependencies(
      ISettingsFeatureDependencies dependencies);

  SettingsScreenComponent build();
}

extension SettingsComponentExt on SettingsPage {
  Widget wrap(ISettingsFeatureDependencies dependencies) =>
      ComponentHolder<SettingsPage, SettingsPageState>(
        componentFactory: (SettingsPageState state) =>
            JuggerSettingsScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
