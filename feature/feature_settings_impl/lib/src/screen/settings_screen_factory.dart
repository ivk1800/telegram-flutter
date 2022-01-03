import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_impl/src/di/settings_screen_component.dart';
import 'package:feature_settings_impl/src/di/settings_screen_component.jugger.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'setting_view_model.dart';
import 'settings_page.dart';

class SettingsScreenFactory implements ISettingScreenFactory {
  SettingsScreenFactory({
    required SettingsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SettingsFeatureDependencies _dependencies;

  @override
  Widget create() {
    return Scope<SettingsScreenComponent>(
      create: () {
        return JuggerSettingsScreenComponentBuilder()
            .dependencies(_dependencies)
            .build();
      },
      providers: (SettingsScreenComponent component) {
        return <Provider<dynamic>>[
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          ),
          Provider<tg.TgAppBarFactory>(
            create: (_) => component.getTgAppBarFactory(),
          ),
          Provider<tg.ConnectionStateWidgetFactory>(
            create: (_) => component.getConnectionStateWidgetFactory(),
          ),
          Provider<ISettingsSearchScreenFactory>(
            create: (_) => component.getSettingsSearchWidgetFactory(),
          ),
          Provider<SettingViewModel>(
            create: (_) => component.getSettingViewModel(),
          ),
        ];
      },
      child: const SettingsPage(),
    );
  }
}
