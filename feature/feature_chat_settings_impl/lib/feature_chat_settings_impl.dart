library feature_chat_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chat_settings_impl/src/chat_settings_screen_router.dart';
import 'package:feature_chat_settings_impl/src/screen/settings/chat_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'src/screen/settings/bloc/chat_settings_bloc.dart';

export 'src/chat_settings_screen_router.dart';

class ChatSettingsFeatureApi implements IChatSettingsFeatureApi {
  ChatSettingsFeatureApi(
      {required IChatSettingsFeatureDependencies dependencies})
      : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

  final IChatSettingsWidgetFactory _settingsWidgetFactory;

  @override
  IChatSettingsWidgetFactory get screenWidgetFactory => _settingsWidgetFactory;
}

abstract class IChatSettingsFeatureDependencies {
  ILocalizationManager get localizationManager;

  IChatSettingsScreenRouter get router;

  IConnectionStateProvider get connectionStateProvider;
}

class _ScreenWidgetFactory implements IChatSettingsWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final IChatSettingsFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>.value(
              value: dependencies.localizationManager),
          Provider<ConnectionStateWidgetFactory>.value(
              value: ConnectionStateWidgetFactory(
                  connectionStateProvider:
                      dependencies.connectionStateProvider))
        ],
        child: BlocProvider<ChatSettingsBloc>(
            create: (BuildContext context) =>
                ChatSettingsBloc(router: dependencies.router),
            child: const ChatSettingsPage()),
      );
}
