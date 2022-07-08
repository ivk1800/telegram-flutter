import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_impl/src/di/settings_screen_component.jugger.dart';
import 'package:flutter/widgets.dart';

import 'settings_page.dart';
import 'settings_screen_scope_delegate.scope.dart';

class SettingsScreenFactory implements ISettingScreenFactory {
  SettingsScreenFactory({
    required SettingsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SettingsFeatureDependencies _dependencies;

  @override
  Widget create() {
    return SettingsScreenScope(
      child: const SettingsPage(),
      create: () =>
          JuggerSettingsComponentBuilder().dependencies(_dependencies).build(),
    );
  }
}
