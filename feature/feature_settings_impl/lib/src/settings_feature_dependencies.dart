import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_settings_impl/src/settings_screen_router.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

@dependencies
@immutable
class SettingsFeatureDependencies {
  const SettingsFeatureDependencies({
    required this.stringsProvider,
    required this.router,
    required this.settingsSearchScreenFactory,
    required this.fileDownloader,
    required this.userRepository,
    required this.optionsManager,
  });

  final IStringsProvider stringsProvider;
  final ISettingsScreenRouter router;
  final ISettingsSearchScreenFactory settingsSearchScreenFactory;
  final IFileDownloader fileDownloader;
  final IUserRepository userRepository;
  final OptionsManager optionsManager;
}
