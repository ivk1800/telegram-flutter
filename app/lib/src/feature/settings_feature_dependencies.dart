import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class SettingsFeatureDependencies implements ISettingsFeatureDependencies {
  @j.inject
  SettingsFeatureDependencies({
    required ISettingsScreenRouter router,
    required ISettingsSearchFeatureApi settingsSearchFeatureApi,
    required IConnectionStateProvider connectionStateProvider,
    required ILocalizationManager localizationManager,
  })  : _router = router,
        _settingsSearchFeatureApi = settingsSearchFeatureApi,
        _connectionStateProvider = connectionStateProvider,
        _localizationManager = localizationManager;

  final ISettingsScreenRouter _router;
  final ILocalizationManager _localizationManager;
  final IConnectionStateProvider _connectionStateProvider;
  final ISettingsSearchFeatureApi _settingsSearchFeatureApi;

  @override
  ISettingsScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;

  @override
  ISettingsSearchFeatureApi get settingsSearchFeatureApi =>
      _settingsSearchFeatureApi;
}
