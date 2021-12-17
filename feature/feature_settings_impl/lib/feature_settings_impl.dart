library feature_settings_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/src/screen/settings_page.dart';
import 'package:feature_settings_impl/src/settings_screen_router.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

export 'src/settings_screen_router.dart';

class SettingsFeatureApi implements ISettingsFeatureApi {
  SettingsFeatureApi({
    required SettingsFeatureDependencies dependencies,
  }) : _settingsWidgetFactory =
            _ScreenWidgetFactory(dependencies: dependencies);

  final ISettingsWidgetFactory _settingsWidgetFactory;

  @override
  ISettingsWidgetFactory get screenWidgetFactory => _settingsWidgetFactory;
}

class SettingsFeatureDependencies {
  const SettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
    required this.settingsSearchFeatureApi,
  });

  final ILocalizationManager localizationManager;

  final ISettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;

  final ISettingsSearchFeatureApi settingsSearchFeatureApi;
}

class _ScreenWidgetFactory implements ISettingsWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final SettingsFeatureDependencies dependencies;

  @override
  Widget create() => Provider<SettingsFeatureDependencies>(
        create: (BuildContext context) => dependencies,
        child: const SettingsPage(),
      );
}
