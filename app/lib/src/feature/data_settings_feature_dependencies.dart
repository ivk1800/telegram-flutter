import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class DataSettingsFeatureDependencies
    implements IDataSettingsFeatureDependencies {
  @j.inject
  DataSettingsFeatureDependencies({
    required IDataSettingsScreenRouter router,
    required ISettingsSearchFeatureApi settingsSearchFeatureApi,
    required IConnectionStateProvider connectionStateProvider,
    required ILocalizationManager localizationManager,
  })   : _router = router,
        _settingsSearchFeatureApi = settingsSearchFeatureApi,
        _connectionStateProvider = connectionStateProvider,
        _localizationManager = localizationManager;

  final IDataSettingsScreenRouter _router;
  final ILocalizationManager _localizationManager;
  final IConnectionStateProvider _connectionStateProvider;
  final ISettingsSearchFeatureApi _settingsSearchFeatureApi;

  @override
  IDataSettingsScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;

  @override
  ISettingsSearchFeatureApi get settingsSearchFeatureApi =>
      _settingsSearchFeatureApi;
}
