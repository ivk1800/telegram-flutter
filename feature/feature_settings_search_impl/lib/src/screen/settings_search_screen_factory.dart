import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_settings_search_impl/src/di/settings_search_screen_component.jugger.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_page.dart';
import 'package:flutter/widgets.dart';

import 'settings_search_screen_scope_delegate.scope.dart';

class SearchSettingsScreenFactory implements ISettingsSearchScreenFactory {
  SearchSettingsScreenFactory({
    required SettingsSearchFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SettingsSearchFeatureDependencies _dependencies;

  @override
  Widget create(SettingsSearchScreenController controller) {
    return SettingsSearchScreenScope(
      child: SettingsSearchPage(controller: controller),
      create: () => JuggerSettingsSearchScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
