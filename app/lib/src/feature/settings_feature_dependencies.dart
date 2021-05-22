import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class SettingsFeatureDependencies implements ISettingsFeatureDependencies {
  @j.inject
  SettingsFeatureDependencies({
    required ISettingsScreenRouter router,
    required IConnectionStateUpdatesProvider connectionStateUpdatesProvider,
    required ILocalizationManager localizationManager,
  })   : _router = router,
        _connectionStateUpdatesProvider = connectionStateUpdatesProvider,
        _localizationManager = localizationManager;

  final ISettingsScreenRouter _router;
  final ILocalizationManager _localizationManager;
  final IConnectionStateUpdatesProvider _connectionStateUpdatesProvider;

  @override
  ISettingsScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IConnectionStateUpdatesProvider get connectionStateUpdatesProvider =>
      _connectionStateUpdatesProvider;
}
