import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class MainScreenFeatureDependencies implements IMainScreenFeatureDependencies {
  @j.inject
  MainScreenFeatureDependencies(
      {required IChatsListFeatureApi chatsListFeatureApi,
      required IGlobalSearchFeatureApi globalSearchFeatureApi,
      required IMainScreenRouter router,
      required ILocalizationManager localizationManager,
      required IConnectionStateProvider connectionStateProvider})
      : _chatsListFeatureApi = chatsListFeatureApi,
        _globalSearchFeatureApi = globalSearchFeatureApi,
        _router = router,
        _localizationManager = localizationManager,
        _connectionStateProvider = connectionStateProvider;

  final IChatsListFeatureApi _chatsListFeatureApi;
  final IGlobalSearchFeatureApi _globalSearchFeatureApi;
  final IConnectionStateProvider _connectionStateProvider;
  final IMainScreenRouter _router;
  final ILocalizationManager _localizationManager;

  @override
  IChatsListFeatureApi get chatsListFeatureApi => _chatsListFeatureApi;

  @override
  IGlobalSearchFeatureApi get globalSearchFeatureApi => _globalSearchFeatureApi;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;

  @override
  IMainScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;
}
