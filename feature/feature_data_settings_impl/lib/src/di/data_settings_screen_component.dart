import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_data_settings_impl/src/data_settings_screen_router.dart';
import 'package:feature_data_settings_impl/src/screen/data_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'data_settings_screen_component.jugger.dart';

@j.Component(modules: <Type>[DataSettingsModule])
abstract class DataSettingsScreenComponent
    implements IWidgetStateComponent<DataSettingsPage, DataSettingsPageState> {
  @override
  void inject(DataSettingsPageState screenState);
}

@j.module
abstract class DataSettingsModule {
  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
          IDataSettingsFeatureDependencies dependencies) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideConnectionStateProvider(
          IDataSettingsFeatureDependencies dependencies) =>
      dependencies.connectionStateProvider;

  @j.provide
  @j.singleton
  static IDataSettingsScreenRouter provideRouter(
          IDataSettingsFeatureDependencies dependencies) =>
      dependencies.router;
}

@j.componentBuilder
abstract class DataSettingsComponentBuilder {
  DataSettingsComponentBuilder screenState(DataSettingsPageState screen);

  DataSettingsComponentBuilder dependencies(
      IDataSettingsFeatureDependencies dependencies);

  DataSettingsScreenComponent build();
}

extension DataSettingsComponentExt on DataSettingsPage {
  Widget wrap(IDataSettingsFeatureDependencies dependencies) =>
      ComponentHolder<DataSettingsPage, DataSettingsPageState>(
        componentFactory: (DataSettingsPageState state) =>
            JuggerDataSettingsScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
