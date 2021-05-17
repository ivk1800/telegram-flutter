import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:jugger/jugger.dart' as j;

class MainScreenFeatureDependencies implements IMainScreenFeatureDependencies {
  @j.inject
  MainScreenFeatureDependencies(
      {required IChatsListFeatureApi chatsListFeatureApi,
      required IGlobalSearchFeatureApi globalSearchFeatureApi})
      : _chatsListFeatureApi = chatsListFeatureApi,
        _globalSearchFeatureApi = globalSearchFeatureApi;

  final IChatsListFeatureApi _chatsListFeatureApi;
  final IGlobalSearchFeatureApi _globalSearchFeatureApi;

  @override
  IChatsListFeatureApi get chatsListFeatureApi => _chatsListFeatureApi;

  @override
  IGlobalSearchFeatureApi get globalSearchFeatureApi => _globalSearchFeatureApi;
}
