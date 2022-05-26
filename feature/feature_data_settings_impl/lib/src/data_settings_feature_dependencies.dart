import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_data_settings_impl/src/data_settings_screen_router.dart';
import 'package:localization_api/localization_api.dart';

class DataSettingsFeatureDependencies {
  const DataSettingsFeatureDependencies({
    required this.localizationManager,
    required this.router,
    required this.connectionStateProvider,
  });

  final ILocalizationManager localizationManager;

  final IDataSettingsScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
