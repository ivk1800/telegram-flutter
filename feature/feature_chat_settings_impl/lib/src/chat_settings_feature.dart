import 'package:coreui/coreui.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chat_settings_impl/src/screen/settings/chat_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'chat_settings_feature_dependencies.dart';
import 'screen/settings/chat_settings_view_model.dart';

class ChatSettingsFeature implements IChatSettingsFeatureApi {
  ChatSettingsFeature({
    required ChatSettingsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatSettingsFeatureDependencies _dependencies;

  @override
  late final IChatSettingsWidgetFactory screenWidgetFactory =
      _ScreenWidgetFactory(dependencies: _dependencies);
}

class _ScreenWidgetFactory implements IChatSettingsWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final ChatSettingsFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>.value(
            value: dependencies.localizationManager,
          ),
          Provider<ConnectionStateWidgetFactory>.value(
            value: ConnectionStateWidgetFactory(
              connectionStateProvider: dependencies.connectionStateProvider,
            ),
          ),
          Provider<ChatSettingsViewModel>(
            create: (_) => ChatSettingsViewModel(router: dependencies.router),
            dispose: (_, ChatSettingsViewModel value) => value.dispose(),
          ),
        ],
        child: const ChatSettingsPage(),
      );
}
