import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:feature_chat_settings_impl/src/di/chat_settings_screen_component.jugger.dart';
import 'package:feature_chat_settings_impl/src/chat_settings_screen_router.dart';
import 'package:feature_chat_settings_impl/src/screen/chat_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[ChatSettingsModule])
abstract class ChatSettingsScreenComponent
    implements IWidgetStateComponent<ChatSettingsPage, ChatSettingsPageState> {
  @override
  void inject(ChatSettingsPageState screenState);
}

@j.module
abstract class ChatSettingsModule {
  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
          IChatSettingsFeatureDependencies dependencies) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static IConnectionStateProvider provideConnectionStateProvider(
          IChatSettingsFeatureDependencies dependencies) =>
      dependencies.connectionStateProvider;

  @j.provide
  @j.singleton
  static IChatSettingsScreenRouter provideRouter(
          IChatSettingsFeatureDependencies dependencies) =>
      dependencies.router;
}

@j.componentBuilder
abstract class ChatSettingsComponentBuilder {
  ChatSettingsComponentBuilder screenState(ChatSettingsPageState screen);

  ChatSettingsComponentBuilder dependencies(
      IChatSettingsFeatureDependencies dependencies);

  ChatSettingsScreenComponent build();
}

extension ChatSettingsComponentExt on ChatSettingsPage {
  Widget wrap(IChatSettingsFeatureDependencies dependencies) =>
      ComponentHolder<ChatSettingsPage, ChatSettingsPageState>(
        componentFactory: (ChatSettingsPageState state) =>
            JuggerChatSettingsScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
