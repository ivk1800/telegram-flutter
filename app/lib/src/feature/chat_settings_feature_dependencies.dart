import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class ChatSettingsFeatureDependencies
    implements IChatSettingsFeatureDependencies {
  @j.inject
  ChatSettingsFeatureDependencies({
    required IChatSettingsScreenRouter router,
    required IConnectionStateProvider connectionStateProvider,
    required ILocalizationManager localizationManager,
  })  : _router = router,
        _connectionStateProvider = connectionStateProvider,
        _localizationManager = localizationManager;

  final IChatSettingsScreenRouter _router;
  final ILocalizationManager _localizationManager;
  final IConnectionStateProvider _connectionStateProvider;

  @override
  IChatSettingsScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;
}
