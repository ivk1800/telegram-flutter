import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class NotificationsSettingsFeatureDependencies
    implements INotificationsSettingsFeatureDependencies {
  @j.inject
  NotificationsSettingsFeatureDependencies({
    required INotificationsSettingsScreenRouter router,
    required IConnectionStateProvider connectionStateProvider,
    required ILocalizationManager localizationManager,
  })   : _router = router,
        _connectionStateProvider = connectionStateProvider,
        _localizationManager = localizationManager;

  final INotificationsSettingsScreenRouter _router;
  final ILocalizationManager _localizationManager;
  final IConnectionStateProvider _connectionStateProvider;

  @override
  INotificationsSettingsScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;
}
