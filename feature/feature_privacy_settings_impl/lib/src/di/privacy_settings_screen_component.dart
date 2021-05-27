import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_privacy_settings_impl/feature_privacy_settings_impl.dart';
import 'package:feature_privacy_settings_impl/src/di/privacy_settings_screen_component.jugger.dart';
import 'package:feature_privacy_settings_impl/src/privacy_settings_screen_router.dart';
import 'package:feature_privacy_settings_impl/src/screen/privacy_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[PrivacySettingsModule])
abstract class PrivacySettingsScreenComponent
    implements
        IWidgetStateComponent<PrivacySettingsPage, PrivacySettingsPageState> {
  @override
  void inject(PrivacySettingsPageState screenState);
}

@j.module
abstract class PrivacySettingsModule {
  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
          IPrivacySettingsFeatureDependencies dependencies) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideconnectionStateProvider(
          IPrivacySettingsFeatureDependencies dependencies) =>
      dependencies.connectionStateProvider;

  @j.provide
  @j.singleton
  static IPrivacySettingsScreenRouter provideRouter(
          IPrivacySettingsFeatureDependencies dependencies) =>
      dependencies.router;
}

@j.componentBuilder
abstract class PrivacySettingsComponentBuilder {
  PrivacySettingsComponentBuilder screenState(PrivacySettingsPageState screen);

  PrivacySettingsComponentBuilder dependencies(
      IPrivacySettingsFeatureDependencies dependencies);

  PrivacySettingsScreenComponent build();
}

extension PrivacySettingsComponentExt on PrivacySettingsPage {
  Widget wrap(IPrivacySettingsFeatureDependencies dependencies) =>
      ComponentHolder<PrivacySettingsPage, PrivacySettingsPageState>(
        componentFactory: (PrivacySettingsPageState state) =>
            JuggerPrivacySettingsScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
