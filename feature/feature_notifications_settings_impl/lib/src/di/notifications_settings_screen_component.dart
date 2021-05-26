import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:feature_notifications_settings_impl/src/di/notifications_settings_screen_component.jugger.dart';
import 'package:feature_notifications_settings_impl/src/notifications_settings_screen_router.dart';
import 'package:feature_notifications_settings_impl/src/screen/notifications_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[NotificationsSettingsModule])
abstract class NotificationsSettingsScreenComponent
    implements
        IWidgetStateComponent<NotificationsSettingsPage,
            NotificationsSettingsPageState> {
  @override
  void inject(NotificationsSettingsPageState screenState);
}

@j.module
abstract class NotificationsSettingsModule {
  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
          INotificationsSettingsFeatureDependencies dependencies) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideConnectionStateProvider(
          INotificationsSettingsFeatureDependencies dependencies) =>
      dependencies.connectionStateProvider;

  @j.provide
  @j.singleton
  static INotificationsSettingsScreenRouter provideRouter(
          INotificationsSettingsFeatureDependencies dependencies) =>
      dependencies.router;
}

@j.componentBuilder
abstract class NotificationsSettingsComponentBuilder {
  NotificationsSettingsComponentBuilder screenState(
      NotificationsSettingsPageState screen);

  NotificationsSettingsComponentBuilder dependencies(
      INotificationsSettingsFeatureDependencies dependencies);

  NotificationsSettingsScreenComponent build();
}

extension NotificationsSettingsComponentExt on NotificationsSettingsPage {
  Widget wrap(INotificationsSettingsFeatureDependencies dependencies) =>
      ComponentHolder<NotificationsSettingsPage,
          NotificationsSettingsPageState>(
        componentFactory: (NotificationsSettingsPageState state) =>
            JuggerNotificationsSettingsScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
